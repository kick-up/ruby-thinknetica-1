require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative './carriage'

class CargoCarriage < Carriage
  def initialize(number, volume)
    @type = "Cargo"
    @available_volume = volume
    @loaded_volume = 0
    super
  end

  def load_cargo(volume)
    return if volume > @available_volume
    @available_volume -= volume
    @loaded_volume += volume
  end

  def available_volume?
    @available_volume
  end

  def loaded_volume?
    @loaded_volume
  end

  def to_s
    [number, type, manufacturer, "Доступный объем: #{@available_volume}", "Объем загрузки: #{@loaded_volume}"].join(" - ")
  end
end
