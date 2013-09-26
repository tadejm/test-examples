# 1. Remove Car's explicit reference to Engine by using dependency injection.
# 2. Spec the Car class, in isolation.

class Car
  attr_reader :engine

  def initialize engine
    @engine = engine
  end

  def move
    engine.accelerate
  end
end

class Engine
  attr_reader :cylinders

  def initialize(cylinders)
    @cylinders = cylinders
  end

  def accelerate

  end
end
