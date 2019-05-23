require_relative("route")
require_relative("station")
require "./carriage/carriage"
require "./carriage/cargo_carriage"
require "./carriage/passenger_carriage"
require "./train/train"
require "./train/cargo_train"
require "./train/passenger_train"

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
    # @transit_stations = []
  end

  def menu
    puts "Панель управления железно-дорожной станцией. Выберите действие указав соответсвующий номер:"
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создание маршрута маршрутами"
    puts "4. Назначение маршрута поезду"
    puts "5. Прицепить вагон"
    puts "6. Отцепить вагон"
    puts "7. Управление поездом"
    puts "8. Список станций и поездов на станции"
    puts "9. Управление маршрутами"
  end

  def create_station
    puts "Введите название станции:"
    new_station = gets.chomp
    @stations << Station.new(new_station)
    puts "Вы добавили станцию #{new_station}"
  end

  def create_train
    puts "Выберите тип поезда. Укажите 1 для пассажирского и 2 для грузового(для выхода, введите stop):"
    user_train_choice = gets.chomp
    case user_train_choice
    when "1"
      puts "Укажите номер поезда:"
      train_number = gets.chomp.to_s
      @trains << PassengerTrain.new(train_number)
    when "2"
      puts "Укажите номер поезда:"
      train_number = gets.chomp.to_s
      @trains << CargoTrain.new(train_number)
    end
  end

  def create_route
    puts "Укажите начальную станцию, выбрав индекс из списка"
    show_collection(@stations)
    origin_station = gets.chomp.to_i

    puts "Укажите конечную станцию, выбрав из списка"
    show_collection(@stations)
    destination_station = gets.chomp.to_i

    @routes << Route.new(@stations[origin_station - 1], @stations[destination_station - 1])
  end

  def route_manager
    puts "Для добавления транзитной станции, нажмите 1. Для удаления - 2."
    transit_manager = gets.chomp.to_s
    case transit_manager
    when "1"
      puts "Выберите маршрут из списка, указав индекс"
      show_collection(@routes)
      route = gets.chomp.to_i
      puts "Выберите следующую транзитную станцию:"
      show_collection(@stations)
      transit_station = gets.chomp.to_i
      @routes[route - 1].add_transit_station(@stations[transit_station - 1])
    when "2"
      puts "Выберите маршрут из списка, указав индекс"
      show_collection(@routes)
      route = gets.chomp.to_i
      puts "Выберите транзитную станцию для удаления:"
      show_collection(@stations)
      transit_station = gets.chomp.to_i
      @routes[route - 1].delete_transit_station(@stations[transit_station - 1])
    end
  end

  def assign_route
    puts "Выберите поезд из списка, указав индекс"
    show_collection(@trains)
    train = gets.chomp.to_i

    puts "Выберите маршрут из списка, указав индекс"
    show_collection(@routes)
    route = gets.chomp.to_i

    @trains[train - 1].accept_route(@routes[route-1])
  end

  def attach_carriage_controller
    puts "Чтобы прицепить вагон к поезду, укажите индекс поезда"
    show_collection(@trains)
    train = gets.chomp.to_i
    puts "Выберите тип вагона: 1 - Passenger или 2 - Cargo"
    carriage = gets.chomp.to_s
    case carriage
    when "1"
      @trains[train - 1].attach_carriage(PassengerCarriage.new)
    when "2"
      @trains[train - 1].attach_carriage(CargoCarriage.new)
    end
    p @trains
  end

  def detach_carriage_controller
    puts "Чтобы отцепить вагон от поезда, укажите индекс поезда"
    show_collection(@trains)
    train = gets.chomp.to_i
    puts "Выберите вагон, который хотите отцепить"
    show_collection(@trains[train - 1].carriages)
    carriage = gets.chomp.to_i
    @trains[train - 1].detach_carriage(@trains[train - 1].carriages[carriage - 1])
  end

  def train_controller
    puts "Чтобы управлять поездом, укажите индекс поезда"
    show_collection(@trains)
    train = gets.chomp.to_i
    puts "Выберите направление движения: 1 - вперед, 2 - назад"
    direction = gets.chomp.to_i
    case direction
    when "1"
      @trains[train - 1].move_forward
    when "2"
      @trains[train - 1].move_backward
    end
    puts "Текущая станция: #{@trains[train - 1].current_station}"
  end

  def show_assets
    puts "Список станций:"
    show_collection(@stations)
    puts "Список поездов:"
    show_collection(@trains)
  end

  def show_collection(collection)
    collection.each.with_index(1) do |item, index|
      puts "#{index} - #{item}"
    end
  end

  # def select_from_collection(collection)
  #   index = gets.to_i - 1
  #   return unless index.positive?
  #   collection[index]
  # end


  def run
    loop do
      menu
      choice = gets.chomp
      case choice
      when "1"
        create_station

      when "2"
        create_train

      when "3"
        create_route

      when "4"
        assign_route

      when "5"
        attach_carriage_controller

      when "6"
        detach_carriage_controller

      when "7"
        train_controller

      when "8"
        show_assets

      when "9"
        route_manager
      end
      break if choice == "stop"
    end
  end
end

new_session = Main.new
new_session.run
