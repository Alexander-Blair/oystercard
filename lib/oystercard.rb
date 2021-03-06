
class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise("Maximum limit £#{MAXIMUM_BALANCE} exceeded") if exceeds_limit?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail("Insufficient funds, please top up") if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def exceeds_limit?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end
end
