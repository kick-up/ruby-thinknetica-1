require_relative './instance_counter'
require_relative './valid'

class Station
  attr_reader :name, :trains

  NAME_FORMAT = /^[\w]{2,}$/
  INVALID_NAME = "Неверный формат. Используйте любые 2 латинские буквы, цифры и символы - и _"

  include InstanceCounter
  include Valid

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
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

  protected

  def validate!
    raise INVALID_NAME if @name !~ NAME_FORMAT
  end
end
