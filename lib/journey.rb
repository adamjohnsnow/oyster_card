

class Journey
attr_reader :new_journey

def initialize(oyster_card, start, finish)
  @new_journey = {time: Time.now.round, entry: start, exit: finish, charge: 1}
  oyster_card.journeys << @new_journey
end

end
