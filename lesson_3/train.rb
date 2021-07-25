class Train
  attr_reader :number, :speed, :type, :carrieges_amount

  def initialize(options)
    @number = options[:number]
    @type = options[:type]
    @carrieges_amount = options[:carrieges_amount] || 0
    @speed = 0
    @route = nil
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
    route.init
  end

  def current_station
    @route.current_station
  end

  def move(direction)
    if direction == 'forward'
      @route.next_station
    else
      @route.prev_station
    end
  end

  def next_station
    @route.get_next_station
  end

  def prev_station
    @route.get_prev_station
  end
end
