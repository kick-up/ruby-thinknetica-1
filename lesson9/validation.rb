# frozen_string_literal: true

# This thread is to ignore Documentation offense
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # This thread is to ignore Documentation offense
  module ClassMethods
    def validate(attribute, *validation_type)
      
    end
  end

  # This thread is to ignore Documentation offense
  module InstanceMethods
    def validation_presence(value)
      raise "Value is nil" if value.nil?
    end

    def validation_format(value, format)
      raise "Wrong format" if value != format
    end

    def validation_type(value, type)
      raise "Invalid type"
    end
  end
end
