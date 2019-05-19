require_relative("route")
require_relative("station")

class Train
  attr_reader :carriages_count, :route, :speed, :type, :number
  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages_count = carriages_count
    @speed = 0
    @current_station_index = 0
    @route = []
  end

  def increase_speed(n)
    @speed += n
  end

  def decrease_speed(n)
    @speed -= n
    @speed = 0 if @speed < 0
  end

  def attach_carriage
    return unless @speed.zero?

    @carriages_count += 1 
  end

  def detach_carriage
    return unless @speed.zero?

    return unless @carriages_count.positive?

    @carriages_count -= 1 
  end

  def accept_route(route)
    @route = route
    @current_station_index = 0
    current_station.train_in(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    return unless @current_station_index.positive?

    @route.stations[@current_station_index - 1]
  end

  def move_forward
    return if next_station.nil?

    current_station.train_out(self)
    @current_station_index += 1
    current_station.train_in(self)
  end

  def move_backward
    return if previous_station.nil?

    current_station.train_out(self)
    @current_station_index -= 1
    current_station.train_in(self)
  end
end
