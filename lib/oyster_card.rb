# Oystercard class

class Oystercard
  DEFAULT_LIMIT = 90
  attr_accessor :balance, :in_journey

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise ("You cannot have more than £ #{DEFAULT_LIMIT} on your card") if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end
end
