module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      var_name = "@#{attribute}".to_sym
      history_var_name = "@#{attribute}_history".to_sym

      define_method(attribute) { instance_variable_get(var_name) }
      define_method("#{attribute}_history") { instance_variable_get(history_var_name) }

      define_method("#{attribute}=".to_sym) do |value|
        if instance_variable_get(history_var_name).nil?
          instance_variable_set(history_var_name, [])
        else
          old_value = instance_variable_get(var_name)
          instance_variable_get(history_var_name) << old_value
        end
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(attribute, klass)
    var_name = "@#{attribute}".to_sym

    define_method(attribute) { instance_variable_get(var_name) }

    define_method("#{attribute}=".so_sym) do |value|
      raise "Type mismatch" unless value.is_a?(klass)
      instance_variable_set(var_name, value)
    end
  end
end
