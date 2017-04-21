require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

## This class understands that touching in always creates a new journey
## and that touching out ends an existing journey
## and that touching out sometimes creates an incomplete journey
## and understands and manages a balance
## and understands whether or not it is currently in use

class Oystercard
  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_CHARGE = 6

  attr_reader :journey_log, :trip

  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new
    @trip = nil
  end

  def top_up(amount)
    raise "You cannot have more than £#{DEFAULT_LIMIT} on your card" if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "You must have £#{DEFAULT_MINIMUM} on your card to make journey" if @balance < DEFAULT_MINIMUM
    touch_in_bad if in_journey?
    @trip = Journey.new.start_journey(station)
  end

  def touch_out(station)
    in_journey? ? touch_out_good(station) : touch_out_bad(station)
  end

  private

  def touch_out_good(station)
    @journey_log.log(@trip.end_journey(station))
    @trip = nil
    deduct(journey_log.fare)
  end

  def touch_out_bad(station)
    @journey_log.incomplete_journey(Journey.new.end_journey(station))
    deduct(PENALTY_CHARGE)
  end

  def touch_in_bad
    @journey_log.incomplete_journey(@trip)
    deduct(PENALTY_CHARGE)
  end

  def in_journey?
    @trip != nil
  end

  def deduct(amount)
    @balance -= amount
  end
end
