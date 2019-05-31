require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative '../valid'

class Carriage
  attr_reader :type, :number

  NUMBER_FORMAT = /\w/
  NUMBER_NIL = "Номер вагона не может быть пустым значением!"
  EMPTY_STRING = "Номер вагона должен содержать хотя бы один символ"
  INVALID_NUMBER = "Неверный формат. Используйте любые латинские буквы, цифры и символы - и _"


  include Manufacturer
  include InstanceCounter
  include Valid

  def initialize(number)
    @type = type
    @number = number
    register_instance
    validate!
  end

  def to_s
    [number, type, manufacturer].join(" - ")
  end

  protected

  def validate!
    raise NUMBER_NIL if @number.nil?
    raise EMPTY_STRING if @number.length < 1
    raise INVALID_NUMBER if @number !~ NUMBER_FORMAT
  end
end
