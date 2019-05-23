
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
