require_relative 'train'
require_relative 'cargo_carriege'

class CargoTrain < Train
  def initialize(number:)
    super(number: number, type: :cargo)
  end
end
