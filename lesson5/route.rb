require_relative '../instance_counter'

class Route
  attr_reader :origin, :transit_stations, :destination, :stations

  include InstanceCounter

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
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
    [stations.first, *[@transit_stations], stations.last].join(' - ')
  end
end
