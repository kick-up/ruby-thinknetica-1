require_relative '../instance_counter'
require_relative '../manufacturer'

class PassengerCarriage < Carriage
  def initialize(number)
    @type = "Passenger"
    super
  end
end
