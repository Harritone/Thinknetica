require 'rspec'

module InstanceCountable
  module ClassMethods
    def instances
      @instances || 0
    end

    private

    def increment_instance_counter
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.send :increment_instance_counter
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
end

class Dummy
  include InstanceCountable
  def initialize
    register_instance
  end
end

class DummyOne < Dummy
  include InstanceCountable
  # def initialize
  #   super
  # end
end

RSpec.describe Dummy do
  describe '.instances' do
    it 'should have count instances' do
      Dummy.new
      expect(Dummy.instances).to eq(1)
    end

    it 'should not encrease superclass counter' do
      DummyOne.new
      DummyOne.new
      DummyOne.new
      expect(Dummy.instances).to eq(1) # because we incremented it early
      expect(DummyOne.instances).to eq(3)
    end
  end
end
