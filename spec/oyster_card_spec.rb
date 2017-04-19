require './lib/oyster_card'

describe Oystercard do
  let(:station1) { double :station, zone: 1 }
  let(:station2) { double :station, zone: 3 }

  describe 'default #card' do

    it 'has a #balance of zero' do
      expect(subject.balance).to eq(0)
    end

    it 'is able to get variable #balance' do
      card = Oystercard.new(10)
      expect(card.balance).to eq(10)
    end

    it 'should not be in a journey' do
      expect(subject.in_journey?).to eq false
    end

  end

  describe '#top_up' do
    it 'can #top_up' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it 'cannot #top_up over max' do
      maxbal = Oystercard::DEFAULT_LIMIT
      error_text = "You cannot have more than £#{maxbal} on your card"
      expect { subject.top_up(maxbal + 1) }.to raise_error(error_text)
    end
  end

  describe '#touch_in' do
    context '#card has no #balance' do
      it 'should not allow #touch_in if less than min balance' do
        minbal = Oystercard::DEFAULT_MINIMUM
        error_text = "You must have £#{minbal} on your card to make journey"
        expect { subject.touch_in(station1) }.to raise_error(error_text)
      end
    end
    context '#card has #balance' do
      before { subject.top_up(2) }
      it 'should be in journey after #touch_in' do
        subject.touch_in(station1)
        expect(subject).to be_in_journey
      end

    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(10)
      subject.touch_in(station1)
    end

    it 'should deduct correct fare on #touch_out' do
      expect { subject.touch_out(station2) }.to change { subject.balance }.by(-1)
    end
  end
end
