require_relative './modules/manufacturable'

class Carriege
  class CarriegeValidationError < StandardError
    def message
      'Type should be present'
    end
  end
  include Manufacturable
  attr_reader :type

  def initialize(type)
    @type = type
    validate_attributes!
  end

  protected

  def validate_attributes!
    raise CarriegeValidationError if type.nil? || type.empty?
  end
end
