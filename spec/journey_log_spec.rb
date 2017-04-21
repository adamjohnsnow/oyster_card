## Tests journey_log

require './lib/journey_log'

describe JourneyLog do
  let(:station) { double :station, name: 'name', zone: 1}
  let(:journey1) { double :journey, current_journey: { start: station } }
  let(:journey2) { double :journey, current_journey: { end: station } }

  it "has an array" do
    expect(subject.journey_log).to eq []
  end


end
