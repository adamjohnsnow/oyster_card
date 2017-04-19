require './lib/journey'

describe Journey do
  let(:station) { double :station }

  context 'capturing stations' do

    it 'captures #journey start' do
      journey = Journey.new(:start, station)
      my_hash = { start: station }
      expect(journey.current_journey).to eq my_hash
    end

    it 'captures #journey end' do
      journey = Journey.new(:end, station)
      my_hash = { end: station }
      expect(journey.current_journey).to eq my_hash
    end

  end

end
