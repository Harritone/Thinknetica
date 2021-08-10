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
