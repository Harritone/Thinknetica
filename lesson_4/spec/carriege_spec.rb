require_relative '../carriege'

RSpec.describe Carriege do
  describe '#initialize' do
    it 'should have type' do
      carriege = described_class.new(:cargo)
      expect(carriege.instance_variable_get(:@type)).to eq(:cargo)
    end
  end
end
