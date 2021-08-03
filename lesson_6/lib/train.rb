class Train
  attr_reader :number, :speed, :type, :carrieges, :route

  def initialize(number:, type:)
    @number = number
    @type = type
    @carrieges = []
    @speed = 0
    @route = nil
    @station_idx = nil
  end

  def to_s
    "Train: number - #{@number}, type - #{@type}, carrieges - #{@carrieges.count}, route - #{@route || 'not assigned'}"
  end

  def speed_up(km_per_hours)
    @speed += km_per_hours
  end

  def slow_down
    @speed = 0
  end

  def attach_carriege(carriege)
    return unless speed.zero?
    return unless carriege.type == self.type

    @carrieges << carriege
  end

  def detach_carriege
    return unless speed.zero? &&
      @carrieges.size.positive?

    @carrieges.pop
  end

  def set_route(route)
    @route = route
    @station_idx = 0
    current_station.take_train(self)
  end

  def current_station
    @route.stations[@station_idx]
  end

  def move_forward
    return unless next_station_exists?

    current_station.depart_train(self)
    @station_idx += 1
    current_station.take_train(self)
  end

  def move_backward
    return unless prev_station_exists?

    current_station.depart_train(self)
    @station_idx -= 1
    current_station.take_train(self)
  end

  def next_station
    return unless next_station_exists?

    @route.stations[@station_idx + 1]
  end

  def prev_station
    return unless prev_station_exists?

    @route.stations[@station_idx - 1]
  end

  protected

  # methods used inside the class should be
  # accessible inside inherited classes

  def next_station_exists?
    @station_idx != @route.stations.size + 1
  end

  def prev_station_exists?
    @station_idx.positive?
  end
end
