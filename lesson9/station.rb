# frozen_string_literal: true
require_relative './instance_counter'
require_relative './validation'
require_relative './accessors'

# This thread is to ignore Documentation offense
class Station

  NAME_FORMAT = /^[\w]{2,}$/
  INVALID_NAME = 'Неверный формат. Используйте любые 2 латинские буквы,'\
    'цифры и символы - и _'

  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :trains

  attr_accessor_with_history :name

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    self.name = name
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

  def each_train
    trains.each do |train|
      yield train
    end
  end

  def to_s
    name
  end
end

# station = Station.new('001')
# p station.name_history
# station.name = '002'
# p station.name_history
# station.name = '003'
# p station.name_history
# station.name = '004'
# p station.name_history
