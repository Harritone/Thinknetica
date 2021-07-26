class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station(station, idx = 1)
    return unless idx_valid?(idx)

    @stations.insert(idx, station)
  end

  def remove_station(station)
    return if @stations.size == 2

    @stations.delete(station)
  end

  private

  def idx_valid?(idx)
    idx < @stations.length &&
      idx.positive?
  end
end
