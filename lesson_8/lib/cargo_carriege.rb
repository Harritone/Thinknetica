require_relative 'carriege'

class CargoCarriege < Carriege
  attr_reader :taken_volume

  def initialize(volume)
    super(:cargo)
    @volume = volume
    @taken_volume = 0
  end

  def to_s
    "Type: #{@type}, volume: #{@volume}, taken volume: #{taken_volume}, free space: #{free_space}."
  end

  def add_volume(vol)
    @taken_volume += vol unless free_space_for?(vol)
  end

  def free_space
    @volume - @taken_volume
  end

  private

  def free_space_for?(vol)
    @volume >= (@taken_volume + vol)
  end
end
