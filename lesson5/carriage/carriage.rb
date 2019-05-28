class Carriage
  attr_reader :type, :number

  include Manufacturer

  def initialize(number)
    @type = type
    @number = number
  end

  def to_s
    [number, type, manufacturer].join(" - ")
  end
end
