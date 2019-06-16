module Accessors
  def attr_accessor_history(*attributes)
    attributes.each do |attribute|
      define_method(attribute.to_sym) do
        instance_variable_get("@#{attribute}".to_sym)
      end

      define_method("#{attribute}_history".to_sym) do
        instance_variable_get("@#{attribute}_history".to_sym)
      end

      define_method("#{attribute}=".to_sym) do |val|

        current_history = instance_variable_get("@#{attribute}_history".to_sym)

        if current_history.nil?
          new_history = [val]
        else
          new_history = current_history << val
        end
      instance_variable_set("@#{attribute}_history".to_sym, new_history)
      instance_variable_set("@#{attribute}".to_sym, val)
      end
    end
  end

  def strong_attr_accessor(attribute, klass)
    define_method(attribute.to_sym) do
      instance_variable_get("@#{attribute}".to_sym)
    end

    define_method("#{attribute}=".to_sym) do |val|
      raise "Type mismatch" unless val.is_a?(klass)

      instance_variable_set("@#{attribute}".to_sym, val)
    end
  end
end
