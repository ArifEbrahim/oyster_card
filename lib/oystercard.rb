class Oystercard
  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_max_balance?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def over_max_balance?(amount)
    (@balance + amount) > MAXIMUM_BALANCE
  end

end