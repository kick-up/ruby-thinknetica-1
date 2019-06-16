# frozen_string_literal: true
require_relative './instance_counter'
require_relative './station'
require_relative './validation'

# This thread is to ignore Documentation offense
class Route
  attr_reader :origin, :transit_stations, :destination

  OBJECT_NIL = 'Маршрут должен иметь начальную или конечную станцию'
  DOUBLE_APPEARANCE = 'Станция не может быть конечной и начальной одновременно'

  include InstanceCounter
  include Validation

  validate :origin, :type, Station
  validate :destination, :type, Station

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    validate!
    @transit_stations = []
  end

  def add_transit_station(station)
    @transit_stations << station
  end

  def delete_transit_station(station)
    @transit_stations.delete(station)
  end

  def stations
    [@origin, *@transit_stations, @destination]
  end

  def to_s
    [stations.first, @transit_stations, stations.last].join(' - ')
  end
end

# first = Station.new('first')
# last = Station.new('last')
# Route.new(first, last) # - валидация должна проийти
# Route.new([], last) # - должно быть исключение, т.к тип первого   параметра Array, а не Station
