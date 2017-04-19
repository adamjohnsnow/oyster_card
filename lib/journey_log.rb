class JourneyLog
  attr_reader :journey_log, :pending_journey

  def initialize
    @journey_log = []
    @pending_journey = []
  end

  def touch_out(journey_class)
    @journey_log <<  @pending_journey.merge(journey_class.current_journey)
    @pending_journey = []
  end

  def touch_in(journey_class)
    @pending_journey = journey_class.current_journey
  end

  def fare
    Oystercard::DEFAULT_MINIMUM
  end
end
