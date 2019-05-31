require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative '../valid'

class Carriage
  attr_reader :type, :number

  NUMBER_FORMAT = /^[\w]{2,}$/
  INVALID_NUMBER = "Неверный формат. Используйте любые 2 латинские буквы, цифры и символы - и _"


  include Manufacturer
  include InstanceCounter
  include Valid

  def initialize(number)
    @type = type
    @number = number
    validate!
    register_instance
  end

  def to_s
    [number, type, manufacturer].join(" - ")
  end

  protected

  def validate!
    raise INVALID_NUMBER if @number !~ NUMBER_FORMAT
  end
end
