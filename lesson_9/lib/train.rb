require_relative './modules/manufacturable'
require_relative './modules/instance_countable'
require_relative './modules/validatable'

class Train
  class TrainNumberValidationError < StandardError
    def message
      'Number should consists of 3 letters/digits + optional "-" + 2 letters/digits'
    end
  end

  class TrainTypeValidationError
    def message
      'Type should be present'
    end
  end

  FORMAT = /^[A-z0-9]{3}-?[A-z0-9]{2}$/.freeze

  include Manufacturable
  include InstanceCountable
  include Validatable

  attr_reader :number, :speed, :type, :carrieges, :route

  validate :number, :presence
  validate :number, :format, FORMAT
  validate :type, :presence

  @@trains = []

  class << self
    def find_by_number(number)
      @@trains.detect { |t| t.number == number }
    end
  end

  def initialize(number:, type:)
    @number = number
    @type = type
    # validate_attributes!
    @carrieges = []
    @speed = 0
    @route = nil
    @station_idx = nil
    @@trains << self
    register_instance
  end

  def with_carrieges(&_blk)
    @carrieges.each_with_index { |carriege, i| yield(carriege, i) }
  end

  def to_s
    "Train: number - #{@number}, type - #{@type}, carrieges - #{carrieges.count}, route - #{@route || 'not assigned'}"
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

  def validate_attributes!
    raise TrainNumberValidationError unless valid_number?
    raise TrainTypeValidationError if type.nil? || type.empty?
  end

  def valid_number?
    regexp_en = /^[A-z0-9]{3}-?[A-z0-9]{2}$/
    regexp_ru = /^[А-я0-9]{3}-?[А-я0-9]{2}$/

    return false unless !!regexp_en.match(number) || !!regexp_ru.match(number)

    true
  end

  def next_station_exists?
    @station_idx != @route.stations.size + 1
  end

  def prev_station_exists?
    @station_idx.positive?
  end
end
