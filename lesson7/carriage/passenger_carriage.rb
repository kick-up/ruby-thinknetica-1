require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative './carriage'

class PassengerCarriage < Carriage

  def initialize(number, volume)
    @type = "Passenger"
    super
  end

  def to_s
    volume_info = "Свободные места: #{available_volume}", "Занятые места: #{volume_reserved}"
    [number, type, manufacturer, volume_info].join(" - ")
  end
end













