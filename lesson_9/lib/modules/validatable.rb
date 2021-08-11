module Validatable
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, arg)
      @validations ||= []
      @validations << {name: name, type: type, args: arg}
    end
  end

  module InstanceMethods
    def valid?
      validate!
    end

    protected

    def validate!
      raise 'Nothing to validate!' if self.class.validations.empty?

      self.class.validations.each do |validation|
        validation[:value] = instance_variable_get("@#{validation[:name]}")
        send(validation[:type], validation)
      end
      true
    end

    def presence(opts)
      msg = "Attribute #{opts[:name]} should be present"
      raise msg if opts[:value].to_s.empty?
    end

    def format(opts)
      msg = "Incorrect format of #{opts[:name]}"
      raise msg unless !!opts[:arg].match(opts[:value])
    end

    def type(opts)
      msg = "The #{opts[:name]} should be a type of #{opts[:arg]}"
      raise msg unless opts[:value].is_a? opts[:arg]
    end
  end
end
