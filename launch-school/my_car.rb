
class MyCar
  attr_accessor :color
  attr_reader :year
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def spray_paint(color)
    self.color = color
  end

  def speed_up(n)
    @current_speed = n
    puts @current_speed
  end

  def brake
    while @current_speed > 0
      @current_speed -= 5
      puts @current_speed
    end
  end

  def shut_off
    @current_speed = 0
    puts "Engine's off"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    "My car is a #{color}, #{year}, #{@model}!"
  end
end

tesla = MyCar.new(2019, "red", "S")
tesla.speed_up(100)
tesla.brake
tesla.shut_off
puts tesla.color = "black"
puts tesla.year

puts tesla.spray_paint("blue")

MyCar.gas_mileage(13, 351)

puts tesla
