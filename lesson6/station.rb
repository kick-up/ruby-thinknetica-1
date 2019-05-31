require_relative './instance_counter'
require_relative './valid'

class Station
  attr_reader :name, :trains

  NAME_FORMAT = /\w/

  include InstanceCounter
  include Valid

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
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
    raise "Название станции не может быть пустым значением!" if @name.nil?
    raise "Наименование станции должно иметь хотя бы два символа" if @name.length < 2
    raise "Неверный формат. Используйте любые латинские буквы, цифры и символы - и _" if @name !~ NAME_FORMAT
    true
  end
end
