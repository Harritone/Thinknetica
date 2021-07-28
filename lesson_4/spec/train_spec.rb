require_relative '../train'
require_relative '../station'
require_relative '../route'
require_relative '../carriege'

RSpec.describe Train do
  let(:carriege) { Carriege.new(:passanger) }
  let(:station) { Station.new('tvr') }
  let(:station1) { Station.new('kms') }
  let(:station2) { Station.new('msc') }
  let(:route) { Route.new(station1, station2) }

  subject do
    described_class.new(number: 1, type: :passanger)
  end
  describe '#initialize' do
    it 'should  have number' do
      expect(subject.number).to eq(1)
    end

    it 'should have type' do
      expect(subject.type).to eq(:passanger)
    end

    it 'should have 0 carrieges' do
      expect(subject.carrieges).to be_empty
    end

    it 'should have initial speed 0' do
      expect(subject.instance_variable_get(:@speed))
        .to eq(0)
    end

    it 'should not have route' do
      expect(subject.instance_variable_get(:@route))
        .to be_nil
    end
  end

  describe '#speed_up' do
    it 'should increase speed by provided amount' do
      init_speed = subject.speed
      subject.speed_up(50)
      expect(subject.speed).not_to eq(init_speed)
      expect(subject.speed).to eq(50)
    end
  end

  describe '#slow_down' do
    it 'should set speed to 0' do
      subject.speed_up(50)
      subject.slow_down
      expect(subject.speed).to eq(0)
    end
  end

  describe '#attach_carriege' do
    it 'should attach carriage' do
      subject.attach_carriege(carriege)

      expect(subject.carrieges.size)
        .to eq(1)
      expect(subject.carrieges).to include(carriege)
    end

    it 'should not attach carriege when moving' do
      subject.speed_up(50)
      subject.attach_carriege(carriege)

      expect(subject.carrieges).to be_empty
    end
  end

  describe '#detach_carriege' do
    it 'should detach carriege' do
      subject.attach_carriege(carriege)
      subject.detach_carriege

      expect(subject.carrieges)
        .to be_empty
    end

    it 'should not detach carriege when moving' do
      subject.attach_carriege(carriege)
      subject.speed_up(50)
      subject.detach_carriege

      expect(subject.carrieges.size).to eq(1)
      expect(subject.carrieges).to include(carriege)
    end

    it 'should not detach carriege when nothing to detach' do
      expect(subject.carrieges.size).to eq(0)

      subject.detach_carriege
      expect(subject.carrieges.size).to eq(0)
    end
  end

  describe 'set_route' do
    let(:route) { Route.new(Station.new('kms'), Station.new('msc')) }
    it 'should set route' do
      subject.set_route(route)

      expect(subject.instance_variable_get(:@route))
        .not_to be_nil

      expect(subject.instance_variable_get(:@route))
        .to be_instance_of(Route)
    end

    it 'should have current_station to equal first station' do
      subject.set_route(route)
      expect(subject.current_station).to eq(route.stations.first)
    end
  end

  describe '#move' do
    before(:each) do
      route.add_station(station) 
      subject.set_route(route)
    end

    context '#move_forward' do
      it 'should move forward' do
        cur_station = subject.current_station
        next_station = subject.next_station

        expect(cur_station.trains).to include(subject)
        expect(next_station.trains).not_to include(subject)
        subject.move_forward
        expect(cur_station.trains).not_to include(subject)
        expect(next_station.trains).to include(subject)
        expect(subject.current_station).to eq(next_station)
      end
    end

    context '#move_backward' do
      it 'should move backward' do
        subject.move_forward
        station = subject.current_station
        prev_station = subject.prev_station

        expect(station.trains).to include(subject)

        subject.move_backward

        expect(subject.current_station).to eq(prev_station)
        expect(station.trains).not_to include(subject)
        expect(prev_station.trains).to include(subject)
      end
    end
  end

  describe '#next_station' do
    it 'should return next station' do
      subject.set_route(route)
      expect(subject.next_station).to eq(station2)
    end

    it 'should not return next station if it is last' do
      subject.set_route(route)
      subject.move_forward
      expect(subject.next_station).to be_nil
    end
  end

  describe '#prev_station' do
    it 'should return previous station' do
      route.add_station(station)
      subject.set_route(route)
      subject.move_forward

      expect(subject.prev_station).to eq(station1)
    end

    it 'should not return previous station if it is first' do
      subject.set_route(route)
      expect(subject.prev_station).to be_nil
    end
  end
end
