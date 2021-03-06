require 'oystercard'
require 'station'

RSpec.describe 'user stories - ' do
  let (:entry_station) {double :entry_station}
  let (:exit_station) {double :exit_station}
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
  # it 'should be able to deduct from the balance' do
  #   card = Oystercard.new
  #   card.top_up(50)
  #   card.deduct(10)
  #   expect(card.balance).to eq 40
  # end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.
  it 'should allow users to touch in' do
    card = Oystercard.new
    card.top_up(1)
    card.touch_in(entry_station)
    expect(card.in_journey).to eq true
  end

  it 'should allow users to touch out' do
    card = Oystercard.new
    card.touch_out(exit_station)
    expect(card.in_journey).to eq false
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.
  it 'should stop users with less than the minimum balance' do
    card = Oystercard.new
    expect { card.touch_in(entry_station) }.to raise_error "Insufficient funds"
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card
  it 'should deduct the correct amount from the card' do
    card = Oystercard.new
    card.top_up(10)
    card.touch_out(exit_station)
    expect(card.balance).to eq 8
  end

  #   In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  it 'should remember the entry station' do
    card = Oystercard.new
    card.top_up(10)
    card.touch_in(entry_station)
    expect(card.entry_station).to eq(entry_station)
  end

  # In order to know where I have been
  # As a customer
  # I want to see all my previous trips
  it 'should remember all trips made by a user' do
    card = Oystercard.new
    card.top_up(10)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.journeys.length).to eq(1)
  end

  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in
  it 'stations should have a name and zone' do
    station = Station.new("Victoria", 2)
    expect(station.zone).to eq 2
    expect(station.name).to eq("Victoria")
  end


end
