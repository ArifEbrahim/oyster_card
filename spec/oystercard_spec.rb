require 'oystercard'

RSpec.describe Oystercard do
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
      subject.touch_in
      expect(subject.in_journey).to be true
    end

    it 'stops people with insufficient balance' do
      expect { subject.touch_in}.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_out' do
    it 'allows users to touch out' do
      subject.touch_out
      expect(subject.in_journey).to be false
    end

    it 'should deduct the minimum on touch out' do
      expect { subject.touch_out }.to change {subject.balance}.by -Oystercard::MINIMUM_FARE
    end
  end
end
