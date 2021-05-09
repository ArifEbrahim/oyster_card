class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :journeys

  MAXIMUM_BALANCE = 90
  BALANCE_LIMIT = 1
  MINIMUM_FARE = 2

  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if below_min_balance?
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    @journeys << {entry_station: @entry_station, exit_station: station}
    deduct
    @entry_station = nil
  end

  def in_journey
    !@entry_station.nil?
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