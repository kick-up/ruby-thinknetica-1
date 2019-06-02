require_relative '../instance_counter'
require_relative '../manufacturer'
require_relative '../valid'

class Train
  attr_accessor :carriages
  attr_reader :route, :speed, :type, :number

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  INVALID_NUMBER = "Неверный формат. Допустимый формат: три буквы латинские буквы "\
    "или цифры в любом порядке необязательный дефис (может быть, а может нет) "\
    "и еще 2 буквы латинские буквы или цифры после дефиса."

  include Manufacturer
  include InstanceCounter
  include Valid

  @@trains = {}

  def self.trains
    @@trains # выводим хеш
  end

  def self.find(number)
    @@trains[number] # выводим значение ключа
  end

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @current_station_index = 0
    @route = []
    validate!
    @@trains[number] = self # номер => созданный объект
    register_instance
    
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
    return unless attachable_carriage?(carriage)

    @carriages << carriage
  end

  def detach_carriage(carriage)
    return unless @speed.zero?

    @carriages.delete_at(-1)
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

  def each_carriage(&block)
    carriages.each do |carriage|
      block.call(carriage)
    end
  end

  def to_s
    [number, type, manufacturer, "Количество вагонов: #{carriages.count}"].join(" - ")
  end

  protected

  def validate!
    raise INVALID_NUMBER if number !~ NUMBER_FORMAT
  end
end
