require './lib/journey'

describe Journey do
  let(:station) { double :station, name: 'name', zone: 1}
  let(:oystercard) { double subject::Oystercard::DEFAULT_MINIMUM }
  let(:trip) { double :trip, start_station: { entryzone: 1 } , end_station: { exitzone: 3 }}

  context 'capturing stations' do

    it 'captures #journey start' do
      my_hash = { entrytime: Time.new.round, entrystation: 'name', entryzone: 1 }
      subject.start_journey(station)
      expect(subject.start_station).to eq my_hash
    end

    it 'captures #journey end' do
      my_hash = { exittime: Time.new.round, exitstation: 'name', exitzone: 1 }
      subject.end_journey(station)
      expect(subject.end_station).to eq my_hash
    end

  end

    context '#calculate_fare' do
      it 'calculate_fare'do
      expect(subject.calculate_fare(trip)).to eq 2
    end
    end

end
