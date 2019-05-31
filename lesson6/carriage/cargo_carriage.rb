require_relative '../instance_counter'
require_relative '../manufacturer'

class CargoCarriage < Carriage
  def initialize(number)
    @type = "Cargo"
    super
  end
end
