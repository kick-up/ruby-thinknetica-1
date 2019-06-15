# frozen_string_literal: true

# This thread is to ignore Documentation offense
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # This thread is to ignore Documentation offense
  module ClassMethods
    attr_reader :validations
    
    def validate(attribute, *options)
      @validations ||= []
      @validations << { attribute => options }
    end
  end

  # This thread is to ignore Documentation offense
  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation.each do |name, value|
          val = instance_variable_get("@#{name}")
          send("validate_#{value[0]}", val, *value[1])
        end
      end
      true
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate_presence(value)
      raise "Value is nil" if value.nil?
    end

    def validate_format(value, format)
      raise "Wrong format" if value != format
    end

    def validate_type(value, type)
      raise "Invalid type" unless value.is_a?(type)
    end
  end
end
