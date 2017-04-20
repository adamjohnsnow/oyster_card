require './lib/journey_log'

describe JourneyLog do
  let(:station) { double :station, name: 'name', zone: 1}
  let(:journey1) { double :journey, current_journey: { start: station } }
  let(:journey2) { double :journey, current_journey: { end: station } }

  it "has an array" do
    expect(subject.journey_log).to eq []
  end
  describe 'capturing journeys' do
      before { subject.touch_in(station) }

    it 'captures start of a journey' do
      my_hash = { enter: [station.name, station.zone] }
      expect(subject.pending_journey).to eq my_hash
    end

    it 'captures completed journey' do
      subject.touch_out(station)
      my_hash = [{ enter: [station.name, station.zone], exit: [station.name, station.zone] }]
      expect(subject.journey_log).to eq my_hash
    end
    it 'captures incompleted journey' do
      subject.touch_in(station)
      my_hash = [{ enter: [station.name, station.zone], exit: 'NO TOUCH OUT' }]
      expect(subject.journey_log).to eq my_hash
    end
  end

end
