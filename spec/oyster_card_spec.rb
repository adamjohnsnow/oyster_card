require './lib/oyster_card'

describe Oystercard do
  let(:station) { double :station }

  it 'has a #balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'is able to get variable #balance' do
    card = Oystercard.new(10)
    expect(card.balance).to eq(10)
  end

  it 'can #top_up' do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it 'cannot #top_up over max' do
    maxbal = Oystercard::DEFAULT_LIMIT
    error_text = "You cannot have more than £#{maxbal} on your card"
    expect { subject.top_up(maxbal + 1) }.to raise_error(error_text)
  end

  it 'should not be in a journey' do
    expect(subject.in_journey?).to eq false
  end

  it 'should be in journey after #touch_in' do
    card = Oystercard.new(10)
    card.touch_in(station)
    expect(card).to be_in_journey
  end

  it 'should not be in journey after #touch_out' do
    card = Oystercard.new(10)
    card.touch_in(station)
    card.touch_out
    expect(card).to_not be_in_journey
  end

  it 'should not allow #touch_in if less than min balance' do
    minbal = Oystercard::DEFAULT_MINIMUM
    error_text = "You must have £#{minbal} on your card to make journey"
    expect { subject.touch_in(station) }.to raise_error(error_text)
  end

  it 'should deduct minimum fare on #touch_out' do
    card = Oystercard.new(10)
    expect { card.touch_out }.to change { card.balance }.by(-1)
  end

  it '#touch_in remembers #entry_station' do
    card = Oystercard.new(10)
    card.touch_in(station)
    expect(card.entry_station).to eq station
  end

end
