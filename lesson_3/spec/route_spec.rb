require_relative '../route'
require_relative '../station'

RSpec.describe Route do
  let(:first) { Station.new('kms') }
  let(:last) { Station.new('khv') }
  let(:station1) { Station.new('msc') }
  let(:station2) { Station.new('pkn')}

  subject { described_class.new(first, last)}

  describe '#initialize' do
    describe 'stations' do
      it 'should be an array' do
        expect(subject.instance_variable_get(:@stations))
          .to be_instance_of(Array)
      end

      it 'should have 2 stations after initialize' do
        expect(subject.instance_variable_get(:@stations).length)
          .to eq(2)
      end

      it 'should set 2 stations after initialize' do
        expect(subject.instance_variable_get(:@stations).first)
          .to eq(first)

        expect(subject.instance_variable_get(:@stations).last)
          .to eq(last)
      end
    end
  end

  describe '#add_station' do
    context 'valid' do
      it 'should add station' do
        subject.add_station(station1)

        expect(subject.instance_variable_get(:@stations).length)
          .to eq(3)

        expect(subject.instance_variable_get(:@stations))
          .to include(station1)
      end

      it 'should add station after first station when idx not specified' do
        subject.add_station(station1)
        expect(subject.instance_variable_get(:@stations)[1])
          .to eq(station1)

        subject.add_station(station2)
        expect(subject.instance_variable_get(:@stations)[1])
          .to eq(station2)
      end

      it 'should add station at the specified index' do
        subject.add_station(station1)
        subject.add_station(station2, 2)

        expect(subject.instance_variable_get(:@stations)[2])
          .to eq(station2)
      end
    end

    context 'invalid' do
      let(:init_length) {subject.instance_variable_get(:@stations).size}

      it 'should not add station if specified index greater then stations length' do
        subject.add_station(station1, 5)
        expect(subject.instance_variable_get(:@stations).size)
          .to eq(init_length)
      end

      it 'should not add station when specified idx is negative integer' do
        subject.add_station(station1, -5)
        expect(subject.instance_variable_get(:@stations).size)
          .to eq(init_length)
      end
    end
  end

  describe 'remove station' do
    it 'should remove station' do
      subject.add_station(station1)
      subject.remove_station(station1)
      expect(subject.instance_variable_get(:@stations))
        .not_to include(station1)
    end

    it 'should not remove station when only 2 stations' do
      subject.remove_station(first)

      expect(subject.instance_variable_get(:@stations).size)
        .to eq(2)

      expect(subject.instance_variable_get(:@stations))
        .to include(first)
    end
  end
end
