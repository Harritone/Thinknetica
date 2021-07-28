require_relative '../passanger_train'
require_relative '../passanger_carriege'
require_relative '../cargo_carriege'

RSpec.describe PassangerTrain do
  describe '#attach_carriege' do
    let(:cargo) { described_class.new(number: '123') }
    let(:cargo_carriege) { CargoCarriege.new }
    let(:pass_carriege) { PassangerCarriege.new }

    it 'should attach passanger carriege' do
      cargo.attach_carriege(pass_carriege)
      expect(cargo.carrieges.size)
        .to eq(1)
      expect(cargo.carrieges)
        .to include(pass_carriege)
    end

    it 'should not attach cargo carriege' do
      cargo.attach_carriege(cargo_carriege)
      expect(cargo.carrieges.size)
        .to eq(0)
      expect(cargo.carrieges)
        .not_to include(cargo_carriege)
    end
  end
end

