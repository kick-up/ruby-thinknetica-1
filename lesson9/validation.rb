# frozen_string_literal: true

# This thread is to ignore Documentation offense
module Validation
  module ClassMethods
    attr_reader :validations

    def validate(name, type, *params)
      @validations ||= []
      @validations << { name: name, type: type, params: params }
    end
  end

  module InstanceMethods
    def validate_presence(value)
      raise "Value is nil" if value.nil? || value.strip.empty?
    end

    def validate_format(value, format)
      raise "Wrong format" if value !~ format
    end

    def validate_type(value, type)
      raise "Invalid type" unless value.is_a?(type)
    end

    def validate!
      self.class.validations.each do |validation|
        val = instance_variable_get("@#{validation[:name]}")
        send "validate_#{validation[:type]}", val, *validation[:params]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError => e
      false
    end
    # Содержит инстанс-метод valid? который возвращает true,
    # если все проверки валидации прошли успешно и false, если есть ошибки валидации.
  end
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
