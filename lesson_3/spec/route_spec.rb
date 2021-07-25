require_relative '../route'
require_relative '../station'

RSpec.describe Route do
  let(:first) { Station.new('kms') }
  let(:last) { Station.new('khv') }
  let(:station1) { Station.new('msc') }
  let(:station2) { Station.new('pkn')}

  subject { described_class.new(first: first, last: last)}

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

    describe 'last_station' do
      it 'should have last station' do
        expect(subject.instance_variable_get(:@last_station))
          .to eq(last)
      end
    end

    describe 'first station' do
      it 'should have first station' do
        expect(subject.instance_variable_get(:@first_station))
          .to eq(first)
      end
    end

    describe 'current_station_idx' do
      it 'should set current_station_idx to 0' do
        expect(subject.instance_variable_get(:@current_station_idx))
          .to eq(0)
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

  describe '#current_station' do
    it 'should return current station' do
      expect(subject.current_station)
        .to eq(first)
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

  describe '#next_station' do
    it 'should move to next station' do
      init_current_station = subject.current_station
      subject.next_station
      expect(subject.current_station).not_to eq(init_current_station)
      expect(subject.current_station).to eq(last)
    end

    it 'should not move to next station when at last station' do
      subject.next_station
      expect(subject.current_station).to eq(last)
      subject.next_station
      expect(subject.current_station).to eq(last)
    end
  end

  describe '#prev_station' do
    it 'should move to previous station' do
      init_current_station = subject.current_station
      subject.next_station
      subject.prev_station

      expect(subject.current_station).to eq(init_current_station)
    end

    it 'should not move to previous station when at first station' do
      expect(subject.current_station).to eq(first)
      subject.prev_station
      expect(subject.current_station).to eq(first)
    end
  end

  describe '#get_next_station' do
    it 'should retrun next station' do
      expect(subject.get_next_station).to eq(last)
    end

    it 'should not return next station if current station is last' do
      subject.next_station
      expect(subject.current_station).to eq(last)

      expect(subject.get_next_station).to be_nil
    end
  end

  describe '#get_prev_station' do
    it 'should return previous station' do
      subject.next_station

      expect(subject.get_prev_station).to eq(first)
    end

    it 'should not return next station if current station is first' do
      expect(subject.current_station).to eq(first)

      expect(subject.get_prev_station).to be_nil
    end
  end
end
