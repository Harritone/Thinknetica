module Manufacturable
  attr_accessor :manufacturer
  # def set_manufacturer(manufacturer)
  #   @manufacturer = manufacturer
  # end

  # def get_manufacturer
  #   @manufacturer
  # end
end


require 'rspec'
class Dummy
  include Manufacturable
end

RSpec.describe Dummy do
  describe '#set_manufacturer' do
    it 'should have manufacturer' do
      dummy = Dummy.new
      dummy.manufacturer = 'China'
      expect(dummy.manufacturer).to eq('China')
    end
  end
end
