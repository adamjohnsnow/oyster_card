class JourneyLog
  attr_reader :journey_log, :pending_journey

  def initialize
    @journey_log = []
    @pending_journey = []
  end

  def touch_in(station)
    @pending_journey = Journey.new(station)
  end

  def touch_out(station)
    @pending_journey.end_journey(station)
    log_journey(@pending_journey)
    @pending_journey = []
  end

  def log_journey(completed_journey)
    # incomplete_journey(completed_journey) if
    @journey_log << @pending_journey.start_station.merge(@pending_journey.end_station)
  end


  def incomplete_journey(error_message)
    error_hash = Hash.new
    error_hash[:incomplete_journey] = error_message
    error_hash[:charge] = Oystercard::PENALTY_CHARGE
    @journey_log << @pending_journey.start_station.merge(error_hash)
  end

  def fare
    Oystercard::DEFAULT_MINIMUM
  end
end
