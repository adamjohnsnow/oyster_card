require "./lib/journey"

describe Journey do

  context 'nil #entry_station' do
    let(:station1) { double :station, name: 'test1', zone: 1 }
    let(:station2) { double :station, name: 'test2', zone: 1 }
    let(:oyster_card) { double :oyster_card, journeys: [], entry_station: station1, exit_station: station2}

    it 'captures #journey details with #time, #entry and #exit' do
      journey_log = Journey.new(oyster_card, station1, station2)
      expect(oyster_card.journeys).to eq [{time: Time.new.round, entry: oyster_card.entry_station, exit: oyster_card.exit_station, charge: 1}]
    end
  end

end
