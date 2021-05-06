require 'oystercard'

RSpec.describe Oystercard do
  it 'should have an initial balance of 0'  do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'should allow users to increase the balance' do
      expect { subject.top_up(50) }.to change{ subject.balance }.by 50
    end
  end
end
