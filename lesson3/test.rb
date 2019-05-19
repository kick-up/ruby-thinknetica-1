require_relative("train")
require_relative("route")
require_relative("station")

p almaty_station = Station.new("Almaty")
p astana_station = Station.new("Astana")
p balhash = Station.new("Balhash")
p karaganda = Station.new("Karaganda")

p initial_route = Route.new(almaty_station, astana_station)
p initial_route.add_transit_station(karaganda)
p initial_route.delete_transit_station(karaganda)
p initial_route.add_transit_station(balhash)
p initial_route.add_transit_station(karaganda)
p initial_route.stations

p hogwarts = Train.new("Hogwarts", "Passenger", 1)
p talgo = Train.new("Talgo", "Passenger", 1)
p siberian = Train.new("Siberian", "Cargo", 1)
hogwarts.increase_speed(10)
p hogwarts
hogwarts.decrease_speed(8)
p hogwarts
hogwarts.decrease_speed(8)
p hogwarts
hogwarts.attach_carriage
p hogwarts
hogwarts.increase_speed(1)
p hogwarts
p hogwarts.attach_carriage
p hogwarts.detach_carriage
hogwarts.decrease_speed(8)
p hogwarts
p hogwarts.detach_carriage
p hogwarts
puts "___________________"
p hogwarts.accept_route(initial_route)
p siberian.accept_route(initial_route)
p talgo.accept_route(initial_route)
puts "___________________"
p hogwarts.current_station
puts "___________________"
p hogwarts.next_station
p hogwarts.previous_station
puts "___________________"
p hogwarts.current_station
puts "___________________!!!"
p hogwarts.move_forward
puts "___________________"
p hogwarts.current_station
p hogwarts.move_forward
puts "___________________"
p hogwarts.current_station
p hogwarts.move_forward
puts "___________________"
p hogwarts.current_station
p hogwarts.move_forward
puts "___________________"
p hogwarts.current_station
p hogwarts.move_backward
p hogwarts.current_station
p hogwarts.move_backward
p hogwarts.current_station
p hogwarts.move_backward
p hogwarts.current_station
p hogwarts.move_backward
p hogwarts.current_station
puts "___________________!!!!"
puts almaty_station.train_types("Passenger")
puts "___________________!!!!"
puts almaty_station.train_types("Cargo")
