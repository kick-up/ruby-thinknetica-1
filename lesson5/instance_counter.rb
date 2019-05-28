module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instance
      @@instances
    end
  end

  module InstanceMethods
    def register_instance
      @@instances += 1
    end
  end
end
