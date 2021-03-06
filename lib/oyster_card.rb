require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_CHARGE = 6

  attr_reader :journey_log, :trip, :balance

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
    @trip = nil
  end

  def top_up(amount)
    raise "You cannot have more than £#{DEFAULT_LIMIT} on your card" if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "You must have £#{DEFAULT_MINIMUM} on your card to make journey" if @balance < DEFAULT_MINIMUM
    touch_in_bad if in_journey?
    @trip = Journey.new
    @trip.start_journey(station)
  end

  def touch_out(station)
    in_journey? ? touch_out_good(station) : touch_out_bad(station)
  end

  private

  def touch_out_good(station)
    @trip.end_journey(station)
    fare = @trip.calculate_fare(@trip) + DEFAULT_MINIMUM
    @journey_log.log(@trip)
    @trip = nil
    deduct(fare)
  end

  def touch_out_bad(station)
    @trip = Journey.new
    @journey_log.incomplete_journey(trip.end_journey(station))
    deduct(PENALTY_CHARGE)
    @trip = nil
  end

  def touch_in_bad
    @journey_log.incomplete_journey(@trip)
    deduct(PENALTY_CHARGE)
  end

  def in_journey?
    @trip != nil
  end

  def deduct(fare)
    @balance -= fare
  end
end
