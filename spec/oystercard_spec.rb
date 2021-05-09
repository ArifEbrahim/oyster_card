require 'oystercard'

RSpec.describe Oystercard do
  let (:entry_station) {double :entry_station}
  let (:exit_station) {double :exit_station}
  it 'should have an initial balance of 0'  do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'should allow users to increase the balance' do
      expect { subject.top_up(50) }.to change{ subject.balance }.by 50
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_error "Maximum balance of £#{maximum_balance} exceeded"
    end
  end

  describe '#touch_in' do
    it 'allows users to touch in' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(entry_station)
      expect(subject.in_journey).to be true
    end

    it 'stops people with insufficient balance' do
      expect { subject.touch_in(entry_station) }.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_out' do
    it 'allows users to touch out' do
      subject.touch_out(exit_station)
      expect(subject.in_journey).to be false
    end

    it 'should deduct the minimum on touch out' do
      expect { subject.touch_out(exit_station) }.to change {subject.balance}.by -Oystercard::MINIMUM_FARE
    end
  end

  describe "journey" do
    it 'should remember the entry station' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end

    let (:journey) { {entry_station: entry_station, exit_station: exit_station} }
    it "should remember all trips made by the user" do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end

    it "should start with an empty journey record" do
      expect(subject.journeys).to be_empty
    end

  end
end
