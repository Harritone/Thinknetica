require_relative '../station'
require_relative '../cargo_train'
require_relative '../passanger_train'

RSpec.describe Station do
  let(:name) { 'khv' }
  let(:train) { CargoTrain.new(number: 1) }
  let(:train1) { PassangerTrain.new(number: 1) }
  let(:train2) { CargoTrain.new(number: 3) }
  subject { described_class.new(name) }

  describe '#initialize' do
    it 'should have name' do
      expect(subject.name).to eq(name)
    end

    it 'should not have trains' do
      expect(subject.trains)
        .to be_empty
    end
  end

  describe 'take_train' do
    it 'should add train to the list of trains' do
      subject.take_train(train)
      expect(subject.trains.size)
        .to eq(1)

      expect(subject.trains)
        .to include(train)
    end
  end

  describe '#depart_train' do
    it 'should depart train' do
      subject.take_train(train)
      subject.take_train(train1)
      subject.take_train(train2)

      subject.depart_train(train1)
      expect(subject.trains)
        .not_to include(train1)
    end
  end

  describe '#get_trains_by_type' do
    it 'should return trains by type' do
      subject.take_train(train)
      subject.take_train(train1)
      subject.take_train(train2)

      expect(subject.get_trains_by_type(:cargo).size).to eq(2)
      expect(subject.get_trains_by_type(:cargo))
        .to eq([train, train2])
    end
  end

  describe '#get_trains_amount_by_type' do
    it 'should return amount of trains by given type' do
      subject.take_train(train)
      subject.take_train(train1)
      subject.take_train(train2)

      expect(subject.get_trains_amount_by_type(:cargo)).to eq(2)
    end
  end
end
