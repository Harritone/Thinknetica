class Route
  attr_reader :first, :last, :stations

  def initialize(options)
    @first_station = options[:first]
    @last_station = options[:last]
    @stations = [@first_station, @last_station]
    @current_station_idx = 0
  end

  def add_station(station, idx = 1)
    return unless idx_valid?(idx)

    @stations.insert(idx, station)
  end

  def current_station
    @stations[@current_station_idx]
  end

  def remove_station(station)
    return if @stations.size == 2

    @stations.delete(station)
  end

  def next_station
    return if (@current_station_idx + 1) >= @stations.length

    @current_station_idx += 1
  end

  def prev_station
    return if @current_station_idx.zero?

    @current_station_idx -= 1
  end

  def init
    @current_station_idx = 0
  end

  def get_next_station
    return unless idx_valid?(@current_station_idx + 1)

    @stations[@current_station_idx + 1]
  end

  def get_prev_station
    return if @current_station_idx.zero?

    @stations[@current_station_idx - 1]
  end

  private

  def idx_valid?(idx)
    idx < @stations.length &&
      idx.positive?
  end
end
