
class Journey
  attr_reader :start_station, :end_station

  def start_journey(station)
    @start_station = { entrytime: Time.new.round, entrystation: station.name, entryzone: station.zone }
  end

  def end_journey(station)
    @end_station = { exittime: Time.new.round, exitstation: station.name, exitzone: station.zone }
  end

  def calculate_fare(enter_zone = 0,exit_zone = 0)
    travelled_zones = [enter_zone,exit_zone].sort
    fare = travelled_zones[1] - travelled_zones[0] + Oystercard::DEFAULT_MINIMUM
  end

end
