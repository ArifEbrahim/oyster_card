class Oystercard
  attr_reader :balance, :in_journey

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey
  end

  def top_up(amount)
    raise "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_max_balance?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def over_max_balance?(amount)
    (@balance + amount) > MAXIMUM_BALANCE
  end

end