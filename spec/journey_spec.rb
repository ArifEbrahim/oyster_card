require 'journey'

RSpec.describe Journey do
  let (:entry_station) {double :entry_station}
  let (:exit_station) {double :exit_station}
  # let {:oystercard} {double :oystercard, }

  it 'should remember the entry station' do
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq(entry_station)
  end

  it 'should remember the exit station' do
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end

  
  

end