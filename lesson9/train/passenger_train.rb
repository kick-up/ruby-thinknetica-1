# frozen_string_literal: true
require_relative './train'
require_relative '../instance_counter'
require_relative '../manufacturer'

# This thread is to ignore Documentation offense
class PassengerTrain < Train

  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  
  def initialize(number)
    @type = 'Passenger'
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
