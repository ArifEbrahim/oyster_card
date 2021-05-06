class Oystercard
  attr_reader :balance, :in_journey

  MAXIMUM_BALANCE = 90
  BALANCE_LIMIT = 1
  MINIMUM_FARE = 2


  def initialize
    @balance = 0
    @in_journey
  end

  def top_up(amount)
    raise "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_max_balance?(amount)
    @balance += amount
  end

  def touch_in
    raise "Insufficient funds" if below_min_balance?
    @in_journey = true
  end

  def touch_out
    deduct
    @in_journey = false
  end

  private

  def deduct(amount = MINIMUM_FARE)
    @balance -= amount
  end

  def over_max_balance?(amount)
    (@balance + amount) > MAXIMUM_BALANCE
  end

  def below_min_balance?
    @balance < BALANCE_LIMIT
  end

end