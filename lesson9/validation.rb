# frozen_string_literal: true

# This thread is to ignore Documentation offense
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # This thread is to ignore Documentation offense
  module ClassMethods
    def validate(attribute, type, *options)
      @validations ||= []
      @validations << { attribute: attribute, type: type, options: options }
    end
  end

  # This thread is to ignore Documentation offense
  module InstanceMethods
    def validate!
      self.class.validations.each do |validations|
        validations.each do |attribute, value|
          send("validation_#{value}", instance_variable_get("@#{attribute}"))
        end
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    def validation_presence(value)
      raise "Value is nil" if value.nil?
    end

    def validation_format(value, format)
      raise "Wrong format" if value != format
    end

    def validation_type(value, type)
      raise "Invalid type" unless value.is_a?(type)
    end
  end
end
