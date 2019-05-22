
class Train
  attr_reader :carriages, :route, :speed, :type, :number
  def initialize(number)
    @number = number
    # @type = type
    @carriages = []
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

  def attach_carriage(carriage)
    return unless @speed.zero?

    @carriages << carriage if @type == carriage.type
  end

  def detach_carriage(carriage)
    return unless @speed.zero?

    @carriages.delete_at(-1) if @type == carriage.type
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
