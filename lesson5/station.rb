require_relative("instance_counter")

class Station
  attr_reader :name, :trains

  include InstanceCounter

  @@instances = 0

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def train_in(train)
    @trains << train
  end

  def train_out(train)
    @trains.delete(train)
  end

  def train_types(type)
    @trains.select do |train|
      train.type == type
    end
  end

  def to_s
    name
  end
end

# almaty = Station.new("almaty")
# p Station.instances
