require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative '../valid'

class Carriage
  attr_accessor :volume
  attr_reader :type, :number

  NUMBER_FORMAT = /^[\w]{2,}$/
  INVALID_NUMBER = "Неверный формат. Используйте любые 2 латинские буквы, цифры и символы - и _"


  include Manufacturer
  include InstanceCounter
  include Valid

  def initialize(number, volume)
    @type = type
    @number = number
    @volume = volume
    @volume_reserved = 0
    validate!
    register_instance
  end

  def to_s
    [number, type, manufacturer].join(" - ")
  end

  def take_space(volume=1)
    return if @volume.zero? || volume > @volume
    @volume -= volume
    @volume_reserved += volume
  end

  def available_volume
    @volume
  end

  def volume_reserved
    @volume_reserved
  end

  protected

  def validate!
    raise INVALID_NUMBER if @number !~ NUMBER_FORMAT
  end
end
