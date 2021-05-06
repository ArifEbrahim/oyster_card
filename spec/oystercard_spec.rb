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

  describe '#deduct' do
    it 'reduces the balance by a given amount' do
      expect { subject.deduct(5) }.to change{ subject.balance }.by -5
    end
  end
end
