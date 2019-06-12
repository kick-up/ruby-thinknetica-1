# Написать модуль Acсessors, содержащий следующие методы, которые можно вызывать на уровне класса:

# метод
# attr_accessor_with_history

#  Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
#  при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения.
# Также в класс, в который подключается модуль должен добавляться инстанс-метод
# <имя_атрибута>_history

#   который возвращает массив всех значений данной переменной.

# метод
# strong_attr_accessor

#  который принимает имя атрибута и его класс.
#  При этом создается геттер и сеттер для одноименной инстанс-переменной,
#  но сеттер проверяет тип присваемоего значения.
#  Если тип отличается от того, который указан вторым параметром, то выбрасывается исключение.
#  Если тип совпадает, то значение присваивается.

module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      var_name = "@#{attribute}".to_sym

      define_method(attribute) { instance_variable_get(var_name) }

      define_method("#{attribute}=".so_sym) do |value|
        var_history << value
        instance_variable_set(var_name, value)
        instance_variable_set(var_name, var_history)
      end
    end
  end

  def strong_attr_accessor(attribute, class)
    attribute.each do |attribute|
      var_name = "@#{attribute}".to_sym

      define_method(attribute) { instance_variable_get(var_name) }

      define_method("#{attribute}=".so_sym) do |value|
        if value.class == class
          instance_variable_set(var_name, value)
        else
          raise "Wrong type"
        end
      end
    end
  end
end
