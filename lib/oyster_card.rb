require_relative 'station'
require_relative 'journey'

class Oystercard

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_CHARGE = 6

  attr_accessor :balance, :entry_station, :journeys, :in_journey

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise "You cannot have more than £#{DEFAULT_LIMIT} on your card" if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise "You must have £#{DEFAULT_MINIMUM} on your card to make journey" if @balance < DEFAULT_MINIMUM
    @entry_station = station
  end

  def touch_out(station)
    journey_log = Journey.new(self, @entry_station, station)
    deduct(journey_log.new_journey[:charge])
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
