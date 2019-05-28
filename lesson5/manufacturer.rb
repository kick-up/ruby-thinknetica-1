module Manufacturer
  attr_accessor :manufacturer

  def assign_manufacturer(item, object)
    puts "Чтобы указать компанию-производителя, укажите индекс #{item}"
    show_collection(object)
    object = select_from_collection(object)
    puts "Укажите название компании-производителя"
    object.manufacturer = gets.chomp.to_s
    p object
  end
end
