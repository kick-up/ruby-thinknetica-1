require_relative '../instance_counter'
require_relative '../manufacturer'

class Carriage
  attr_reader :type, :number

  include Manufacturer
  include InstanceCounter

  def initialize(number)
    @type = type
    @number = number
    register_instance
  end

  def to_s
    [number, type, manufacturer].join(" - ")
  end
end
