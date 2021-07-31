require_relative './modules/instance_countable'

class Route
  include InstanceCountable

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    register_instance
  end

  def add_station(station, idx = 1)
    return unless idx_valid?(idx)

    @stations.insert(idx, station)
  end

  def remove_station(station)
    return if @stations.size == 2

    @stations.delete(station)
  end

  def to_s
    "Route from #{@stations.first.name} to #{@stations.last.name}"
  end

  private

  # methods used within the class

  def idx_valid?(idx)
    idx < @stations.length &&
      idx.positive?
  end
end
