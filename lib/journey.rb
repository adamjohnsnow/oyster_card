class Journey
  attr_reader :start_station, :end_station

  def initialize(station)
    @start_station = { entrytime: Time.new.round, entrystation: station.name, entryzone: station.zone }
  end

  def end_journey(station)
    @end_station = { exittime: Time.new.round, exitstation: station.name, exitzone: station.zone }
  end

end
