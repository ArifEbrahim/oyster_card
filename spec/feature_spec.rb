require 'oystercard'

RSpec.describe 'user stories - ' do
# In order to use public transport
# As a customer
# I want money on my card
it 'should have an initial balance of 0' do
  card = Oystercard.new
  expect(card.balance).to eq 0
end



end
