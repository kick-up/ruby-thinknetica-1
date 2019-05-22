require_relative("train")
require_relative("route")
require_relative("station")
require_relative("carriage")
require_relative("cargo_train")
require_relative("passenger_train")

class Terminal
  def initialize
    @station_list = []
    @train_list = []
    @route_list = []
  end

  def run
    loop do
      # Выбор вариантов:
      puts "Панель управления железно-дорожной станцией. Выберите действие указав соответсвующий номер:"
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. Управление маршрутами"
      puts "4. Назначение маршрута поезду"
      puts "5. Прицепить вагон"
      puts "6. Отцепить вагон"
      puts "7. Управление поездом"
      puts "8. Список станций и поездов на станции"

      choice = gets.chomp

      case choice
      when "1" # Создать станцию
        puts "Введите название станции:"
        new_station = gets.chomp
        @station_list << Station.new(new_station)
        puts "Вы добавили станцию #{new_station}"

      when "2" # Создать поезд
        puts "Выберите тип поезда. Укажите 1 для пассажирского и 2 для грузового(для выхода, введите stop):"
        user_train_choice = gets.chomp
        if user_train_choice == "1"
          puts "Укажите номер поезда:"
          train_number = gets.chomp.to_s
          @train_list << PassengerTrain.new(train_number)
        elsif user_train_choice == "2"
          puts "Укажите номер поезда:"
          train_number = gets.chomp.to_s
          @train_list << CargoTrain.new(train_number)
        else
          puts "К сожалению, такой тип отсутствует. Попробуйте еще раз"
        end

      when "3" # Маршрут
        puts "Укажите начальную станцию, выбрав индекс из списка"
        @station_list.each_with_index do |object, index|
          p "#{object.name} с индексом #{index}"
        end
        origin_station = gets.chomp.to_i

        puts "Укажите конечную станцию, выбрав из списка"
        @station_list.each_with_index do |object, index|
          puts "#{object.name} с индексом #{index}"
        end
        destination_station = gets.chomp.to_i

        @route_list << Route.new(@station_list[origin_station], @station_list[destination_station])

      when "4" # Назначение маршрута поезду
        puts "Выберите поезд из списка, указав индекс"
        @train_list.each_with_index do |object, index|
          puts "Номер поезда: #{object.number} с индексом #{index}"
        end
        train = gets.chomp.to_i

        puts "Выберите маршрут из списка, указав индекс"
        @route_list.each_with_index do |object, index|
          puts "#{object} с индексом #{index}"
        end
        route = gets.chomp.to_i

        @train_list[train].accept_route(@route_list[route])

      when "5" # Прицепить вагон
        puts "Чтобы прицепить вагон к поезду, укажите индекс поезда"
        @train_list.each_with_index do |object, index|
          puts "Номер поезда: #{object.number} с индексом #{index}"
        end
        train = gets.chomp.to_i
        puts "Выберите тип вагона: Passenger или Cargo"
        carriage = gets.chomp.to_s
        @train_list[train].attach_carriage(Carriage.new(carriage))

      when "6" # Отцепить вагон
        puts "Чтобы отцепить вагон от поезда, укажите индекс поезда"
        @train_list.each_with_index do |object, index|
          puts "Номер поезда: #{object.number} с индексом #{index}"
        end
        train = gets.chomp.to_i
        puts "Выберите вагон, который хотите отцепить"
        @train_list[train].carriages.each_with_index do |carriage, index|
          puts "#{carriage} с индексом #{index}"
        end
        carriage = gets.chomp.to_i
        @train_list[train].detach_carriage(@train_list[train].carriages[carriage])

      when "7" # Вперед - назад
        puts "Чтобы управлять поездом, укажите индекс поезда"
        @train_list.each_with_index do |object, index|
          puts "Номер поезда: #{object.number} с индексом #{index}"
        end
        train = gets.chomp.to_i 
        puts "Выберите направление движения: 1 - вперед, 2 - назад"
        direction = gets.chomp.to_i
        if direction == 1
          @train_list[train].move_forward
          puts "Предыдущая станция: #{@train_list[train].previous_station}"
          puts "Текущая станция: #{@train_list[train].current_station}"
          puts "Следующая станция: #{@train_list[train].next_station}"
        elsif direction == 2
          @train_list[train].move_backward
        else
          puts "Действие неизвестно"
        end

      when "8"
        puts "Список станций:"
        @station_list.each do |station|
          puts station.name
        end
        puts "Список поездов:"
        @train_list.each do |train|
          puts train.number
        end
    end
      break if choice == "stop"
    end
  end
end

new_session = Terminal.new
new_session.run
