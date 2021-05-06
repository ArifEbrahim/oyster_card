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

end
