require './lib/oyster_card'

describe Oystercard do

  it 'has a #balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'is able to get variable #balance' do
    card = Oystercard.new(10)
    expect(card.balance).to eq(10)
  end

  it 'can #top_up' do
    card = Oystercard.new
    card.top_up(10)
    expect(card.balance).to eq(10)
  end

  it 'cannot #top_up over max' do
    maxbal = Oystercard::DEFAULT_LIMIT
    expect { subject.top_up(maxbal + 1) }.to raise_error("You cannot have more than £#{maxbal} on your card")
  end

  it 'can #deduct from #balance' do
    card = Oystercard.new(10)
    card.deduct(10)
    expect(card.balance).to eq(0)
  end

  it 'should not be in a journey' do
    expect(subject.in_journey?).to eq false
  end

  it 'should be in journey after #touch_in' do
    card = Oystercard.new(10)
    card.touch_in
    expect(card).to be_in_journey
  end

  it 'should not be in journey after #touch_out' do
    card = Oystercard.new(10)
    card.touch_in
    card.touch_out
    expect(card).to_not be_in_journey
  end

  it 'should not allow #touch_in if less than min balance' do
    minbal = Oystercard::DEFAULT_MINIMUM
    expect { subject.touch_in }.to raise_error("You must have £#{minbal} on your card to make journey")
  end
end
