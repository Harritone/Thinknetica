require_relative './modules/manufacturable'

class Carriege
  include Manufacturable
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
