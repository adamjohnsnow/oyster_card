require './lib/journey_log'

describe JourneyLog do
  let(:station) { double :station }
  let(:journey1) { double :journey, current_journey: { start: station } }
  let(:journey2) { double :journey, current_journey: { end: station } }

  it "has an array" do
    expect(subject.journey_log).to eq []
  end
  describe 'capturing journeys' do
      before { subject.touch_in(journey1) }

    it 'captures start of a journey' do
      my_hash = { start: station }
      expect(subject.pending_journey).to eq my_hash
    end

    it 'captures completed journey' do
      subject.touch_out(journey2)
      my_hash = [{ start: station, end: station }]
      expect(subject.journey_log).to eq my_hash
    end
  end

end
