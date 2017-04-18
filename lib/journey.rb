

class Journey


attr_reader :new_journey

  def initialize(oyster_card, start, finish)
    fare = fare(start, finish)
    @new_journey = {time: Time.now.round, entry: start, exit: finish, charge: fare}
    oyster_card.journeys << @new_journey
  end

private

  def fare(start, finish)
    if start == nil || finish ==nil
      Oystercard::PENALTY_CHARGE
    else
      Oystercard::DEFAULT_MINIMUM
    end
  end

end
