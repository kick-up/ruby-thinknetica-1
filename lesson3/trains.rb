# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских <<< сделать после создания поезда
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  attr_reader :name
  def initialize(name)
    @name = name
    @train_list = []
    @train_list_types = []
  end

  def train_in(train)
    @train_list << train.name
    @train_list_types << train.type
  end

  def train_out(train)
    if @train_list.length > 0
      @train_list.delete(train.name)
      @train_list_types.delete(train.type)
    else
      puts "There are no trains at the #{name} station"
    end
  end

  def show_train_list
    p @train_list
    puts "There is/are #{@train_list.length} train(s) at this station"
  end

  def show_train_list_types
    train_list_hash = Hash.new(0)
    @train_list_types.each do |type| 
      train_list_hash.store(type, train_list_hash[type]+1) 
    end
    puts train_list_hash
  end
end

p almaty_station = Station.new("Almaty")
p astana_station = Station.new("Astana")
p balhash = Station.new("Balhash")
p karaganda = Station.new("Karaganda")



# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная
# станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :origin, :route_list, :destination
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @route_list = []
  end

  def add_transit_station(station)
    @route_list << station
  end

  def delete_transit_station(station)
    @route_list.delete(station)
  end

  def create_route_list
    @route_list = [@origin] + @route_list + [@destination]
    p @route_list
  end
end

initial_route = Route.new(almaty_station.name, astana_station.name)
puts "-------------check"
initial_route.add_transit_station(karaganda.name)
puts "-------------"
initial_route.delete_transit_station(karaganda.name)
puts "-------------"
initial_route.add_transit_station(balhash.name)
initial_route.add_transit_station(karaganda.name)
initial_route.create_route_list

# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
# и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто
# увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться
# только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
# но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_accessor :current_speed, :current_location, :transit_count, :type, :name
  attr_reader :car_quantity, :personal_route
  def initialize(name, type, car_quantity)
    @name = name
    @type = type
    @car_quantity = car_quantity
    @current_speed = 0
    @current_location = []
    @personal_route = []
    @transit_count = 0
  end

  def acceleration(n)
    @current_speed += n
  end

  def brake(n)
    if @current_speed - n < 0
      @current_speed = 0
    elsif @current_speed > 0  && @current_speed - n != 0
      @current_speed -= n
    else
      puts "Current speed is already #{@current_speed}"
    end
  end

  def attach_car
    if @current_speed == 0 
      @car_quantity += 1 
    else
      puts "The train is moving!"
    end
  end

  def detach
    if @car_quantity > 0 && @current_speed == 0
      @car_quantity -= 1
    elsif @car_quantity > 0 && @current_speed > 0
      puts "The train is moving!"
    else
      puts "No car to detach"
    end
  end

  def accept_route(route_list)
    @current_location = route_list.origin
    @personal_route = route_list.route_list
    puts @personal_route
  end

  def location
    puts @current_location
  end

  def move_forward
    if @current_location == @personal_route.last || @transit_count == @personal_route.length
      puts "This is the last station. Move backwards or stay!"
    else
      @transit_count += 1
      @current_location = @personal_route[@transit_count]
    end
  end

  def move_backward
    if @current_location == @personal_route.first || @transit_count == 0
      puts "This is the last station. Move forward or stay!"
    else
      @transit_count -= 1
      @current_location = @personal_route[@transit_count]
    end
  end

  def show_nearby_stations
    if @current_location == @personal_route.first
      puts "Current station: #{@current_location}"
      puts "Previous station: #{@personal_route[@transit_count + 1]}"
    elsif @current_location == @personal_route.last
      puts "Previous station: #{@personal_route[@transit_count - 1]}"
      puts "Current station: #{@current_location}"
    else
      puts "Previous station: #{@personal_route[@transit_count - 1]}"
      puts "Current station: #{@current_location}"
      puts "Next station: #{@personal_route[@transit_count + 1]}"
    end
  end
end

# Тесты классов

p new_train = Train.new("Talgo", "passenger", 1)
p old_train = Train.new("Kazpost", "cargo", 1)
p new_train.current_speed
p new_train.current_location
puts "-------------"
p new_train.acceleration(10)
p new_train.current_speed
puts "-------------"
p new_train.brake(8)
p new_train.current_speed
puts "-------------"
p new_train.brake(10)
p new_train.current_speed
puts "-------------"
p new_train.brake(5)
p new_train.current_speed
puts "-------------"
p new_train.car_quantity
p new_train.attach_car
p new_train.car_quantity
puts "-------------"
p new_train.detach
p new_train.car_quantity
puts "-------------"
p new_train.detach
p new_train.car_quantity
puts "-------------"
p new_train.detach
p new_train.car_quantity
puts "------------- Route Part Next"
p new_train.accept_route(initial_route)
puts "-------------"
new_train.location
puts "------------- Check Forward Moving"
new_train.move_forward
new_train.location
new_train.move_forward
new_train.location
new_train.move_forward
new_train.location
new_train.move_forward
new_train.location
puts new_train.transit_count
puts "------------- Check Backward Moving"
new_train.move_backward
new_train.location
new_train.move_backward
new_train.location
new_train.move_backward
new_train.location
new_train.move_backward
new_train.location
new_train.move_forward
new_train.location
puts "------------- Check Nearby Stations"
new_train.show_nearby_stations
new_train.move_forward
new_train.show_nearby_stations
new_train.move_forward
new_train.show_nearby_stations
new_train.move_backward
new_train.show_nearby_stations
new_train.move_backward
new_train.show_nearby_stations
new_train.move_backward
new_train.show_nearby_stations
new_train.move_forward
new_train.show_nearby_stations

p almaty_station.train_in(new_train)
p almaty_station.train_in(old_train)

almaty_station.show_train_list_types
almaty_station.show_train_list

almaty_station.train_out(old_train)
almaty_station.show_train_list_types
almaty_station.show_train_list



















