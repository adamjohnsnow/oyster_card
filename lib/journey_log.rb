class JourneyLog
  attr_reader :journey_log, :pending_journey

  def initialize
    @journey_log = []
  end

  def log(trip)
    @journey_log << trip.start_station.merge(trip.end_station)
  end

  def incomplete_journey(trip)
    @journey_log << trip[:incomplete_journey] = "Penalty(£#{Oystercard:PENALTY_CHARGE})"
  end

  def fare
    Oystercard::DEFAULT_MINIMUM
  end
end
