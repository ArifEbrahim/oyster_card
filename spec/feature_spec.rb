require 'oystercard'

RSpec.describe 'user stories - ' do
  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'should have an initial balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it 'should allow users to top up' do
    card = Oystercard.new
    card.top_up(50)
    expect(card.balance).to eq 50
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card
  it 'should have a maximum balance limit' do
    card = Oystercard.new
    expect{ card.top_up(95) }.to raise_error "Maximum balance of £90 exceeded"
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'should be able to deduct from the balance' do
    card = Oystercard.new
    card.top_up(50)
    card.deduct(10)
    expect(card.balance).to eq 40
  end

end
