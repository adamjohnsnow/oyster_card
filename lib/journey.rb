class Journey
  attr_reader :current_journey

  def initialize(symbol, station)
    @current_journey = {}
    @current_journey[symbol] = station
  end

end
