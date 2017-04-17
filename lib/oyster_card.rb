class Oystercard

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
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
    raise "You must have £#{DEFAULT_MINIMUM} on your card to make journey" if @balance < 1
    @entry_station = station
  end

  def touch_out(station)
    deduct(DEFAULT_MINIMUM)
    @journeys << { entry: @entry_station, exit: station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
