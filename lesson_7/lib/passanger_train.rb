require_relative 'train'
require_relative 'passanger_carriege'

class PassangerTrain < Train
  def initialize(number:)
    super(number: number, type: :passanger)
  end
end
