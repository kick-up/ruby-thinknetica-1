require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative '../valid'

class Carriage
  attr_reader :type, :number

  NUMBER_FORMAT = /\w/

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
    raise "Номер вагона не может быть пустым значением!" if @number.nil?
    raise "Номер вагона должен содержать хотя бы один символ" if @number.length < 1
    raise "Неверный формат. Используйте любые латинские буквы, цифры и символы - и _" if @number !~ NUMBER_FORMAT
    true
  end
end
