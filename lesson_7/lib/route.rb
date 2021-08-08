require_relative './modules/instance_countable'

class Route
  class RouteStationValidationError < StandardError
    def message
      'Staition should be present.'
    end
  end

  include InstanceCountable

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    validate_attributes!
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

  def validate_attributes
    raise RouteStationValidationError unless stations_valid?
  end

  def stations_valid?
    return false if @stations.first.nil? ||
                    @stations.first.empty? ||
                    @stations.last.nil? ||
                    @stations.last.empty?
    true
  end

  def idx_valid?(idx)
    idx < @stations.length &&
      idx.positive?
  end
end
