require_relative("route")
require_relative("station")

class Train
  attr_accessor :current_speed, :current_location, :current_station_index, :type, :name
  attr_reader :carriages_count, :route
  def initialize(name, type, carriages_count)
    @name = name
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
    return unless @route.stations[@current_station_index] != @route.stations.last
    puts "Next station is: #{@route.stations[@current_station_index+1]}"
  end

  def previous_station
    return unless @route.stations[@current_station_index] != @route.stations.first
    puts "Previous station is: #{@route.stations[@current_station_index-1]}"
  end

  def move_forward
    return unless @route.stations[@current_station_index] != @route.stations.last
    current_station.train_out(self)
    @current_station_index += 1
    current_station.train_in(self)
  end

  def move_backward
    return unless @route.stations[@current_station_index] != @route.stations.first
    current_station.train_out(self)
    @current_station_index -= 1
    current_station.train_in(self)
  end
end
