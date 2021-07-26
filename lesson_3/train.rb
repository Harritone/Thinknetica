class Train
  attr_reader :number, :speed, :type, :carrieges_amount

  def initialize(number:, type:, carrieges_amount:)
    @number = number
    @type = type
    @carrieges_amount = carrieges_amount || 0
    @speed = 0
    @route = nil
    @station_idx = nil
  end

  def speed_up(km_per_hours)
    @speed += km_per_hours
  end

  def slow_down
    @speed = 0
  end

  def attach_carriege
    return unless speed.zero?

    @carrieges_amount += 1
  end

  def detach_carriege
    return unless speed.zero? &&
      @carrieges_amount.positive?

    @carrieges_amount -= 1
  end

  def set_route(route)
    @route = route
    @station_idx = 0
  end

  def current_station
    @route.stations[@station_idx]
  end

  def move_forward
    return if @station_idx == @route.stations.size + 1

    @station_idx += 1
  end

  def move_backward
    return if @station_idx.zero?

    @station_idx -= 1
  end

  def next_station
    return if @station_idx == @route.stations.size + 1

    @route.stations[@station_idx + 1]
  end

  def prev_station
    return if @station_idx.zero?

    @route.stations[@station_idx - 1]
  end
end
