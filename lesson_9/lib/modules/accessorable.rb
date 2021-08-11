module Accessorable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |name|
        raise TypeError, 'Method name should be a symbol' unless name.is_a?(Symbol)

        define_method(name) { instance_variable_get("@#{name}") }
        define_method("#{name}=") do |value|
          instance_variable_set("@#{name}", value)
          @history ||= {}
          @history[name] ||= []
          @history[name] << value
        end
        define_method("#{name}_history") { @history[name] }
      end
    end

    def strong_attr_accessor(name, type)
      raise TypeError, 'Method name should be a symbol' unless name.is_a?(Symbol)

      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}=") do |value|
        raise TypeError, "#{value} of type #{value.class} is not a type of #{type}" unless value.class.to_s == type

        instance_variable_set("@#{name}", value)
      end
    end
  end
end
