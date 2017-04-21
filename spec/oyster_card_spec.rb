require './lib/oyster_card'

describe Oystercard do
  let(:journey_log) { double :journey_log }
  let(:station1) { double :station, name: 'name', zone: 1 }
  let(:station2) { double :station, name: 'name', zone: 3 }
  let(:test_card) { Oystercard.new(journey_log) }

  describe 'default #card' do

    it 'has a #balance of zero' do
      expect(test_card.balance).to eq(0)
    end

    it 'should not be in a journey' do
      expect(test_card.trip).to eq nil
    end

  end

  describe '#top_up' do
    it 'can #top_up' do
      expect { test_card.top_up(10) }.to change { test_card.balance }.by(10)
    end

    it 'cannot #top_up over max' do
      maxbal = Oystercard::DEFAULT_LIMIT
      error_text = "You cannot have more than £#{maxbal} on your card"
      expect { test_card.top_up(maxbal + 1) }.to raise_error(error_text)
    end
  end

  describe '#touch_in' do
    context '#card has no #balance' do
      it 'should not allow #touch_in if less than min balance' do
        minbal = Oystercard::DEFAULT_MINIMUM
        error_text = "You must have £#{minbal} on your card to make journey"
        expect { test_card.touch_in(station1) }.to raise_error(error_text)
      end
    end
    context '#card has #balance' do
      before { test_card.top_up(10) }
      it 'should be in journey after #touch_in' do
        test_card.touch_in(station1)
        expect(test_card.trip).not_to eq nil
      end
      it 'should deduct a penalty if card is already in journey' do
        allow(journey_log).to receive(:incomplete_journey)
        test_card.touch_in(station1)
        penalty = Oystercard::PENALTY_CHARGE
        expect{ test_card.touch_in(station1) }.to change { test_card.balance }.by(-penalty)
      end
    end
  end

  describe '#touch_out' do

    before do
      test_card.top_up(10)
      test_card.touch_in(station1)
    end

    describe 'deduction' do

      it 'should deduct 3 on #touch_out' do
        allow(journey_log).to receive(:log)
        allow(journey_log).to receive(:fare).and_return(1)
        expect { test_card.touch_out(station2) }.to change { test_card.balance }.by(-3)
      end

      it 'should deduct 1 on #touch_out' do
        allow(journey_log).to receive(:log)
        allow(journey_log).to receive(:fare).and_return(1)
        expect { test_card.touch_out(station1) }.to change { test_card.balance }.by(-1)
      end

    end

  end
end
