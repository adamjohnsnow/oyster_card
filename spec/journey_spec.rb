require './lib/journey'

describe Journey do
  let(:station) { double :station, name: 'name', zone: 1}

  context 'capturing stations' do

    it 'captures #journey start' do
      journey = Journey.new(station)
      my_hash = { enter: [station.name, station.zone] }
      expect(journey.current_journey).to eq my_hash
    end

    it 'captures #journey end' do
      journey = Journey.new(station)
      journey.end_journey(station)
      my_hash = { enter: [station.name, station.zone], exit: [station.name, station.zone] }
      expect(journey.current_journey).to eq my_hash
    end

  end

end
