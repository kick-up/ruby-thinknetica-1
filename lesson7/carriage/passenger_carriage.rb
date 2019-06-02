require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative './carriage'

class PassengerCarriage < Carriage

  def initialize(number, volume)
    @type = "Passenger"
    @vacant_seats = volume
    @taken_seats = 0
    super
  end

  def reserve_seat
    return if @vacant_seats.zero?
    @vacant_seats -= 1
    @taken_seats += 1
  end

  def vacant_seats?
    @vacant_seats
  end

  def taken_seats?
    @taken_seats
  end

  def to_s
    [number, type, manufacturer, "Свободные места: #{@vacant_seats}", "Занятые места: #{@taken_seats}"].join(" - ")
  end
end
