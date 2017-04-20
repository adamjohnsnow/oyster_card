require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_CHARGE = 6

  attr_accessor :balance, :entry_station, :journeys, :in_journey
  attr_reader :journey

  def initialize(balance = 0)
    @balance = balance
    @journeys = JourneyLog.new
  end

  def top_up(amount)
    raise "You cannot have more than £#{DEFAULT_LIMIT} on your card" if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "You must have £#{DEFAULT_MINIMUM} on your card to make journey" if @balance < DEFAULT_MINIMUM
    penalty_charge if in_journey?
    @journeys.touch_in(station)
  end

  def touch_out(station)
    @journeys.touch_out(station)
    # deduct(journeys.fare)
  end

  def in_journey?
    @journeys.pending_journey != []
  end

  def penalty_charge
    journeys.log_journey(@journeys.pending_journey)
    deduct(PENALTY_CHARGE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
