require_relative("train")
require_relative("route")

class Station
  attr_reader :name, :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  def train_in(train)
    @trains << train
  end

  def train_out(train)
    if @trains.length > 0
      @trains.delete(train)
    end
  end

  def train_types(type)
    @trains.select do |x|
      x = type
    end
  end
end
