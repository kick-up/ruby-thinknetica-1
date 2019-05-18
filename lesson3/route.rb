require_relative("station")
require_relative("train")

class Route
  attr_reader :origin, :transit_stations, :destination
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
end
