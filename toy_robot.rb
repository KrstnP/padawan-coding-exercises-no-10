class ToyRobot

  def initialize
    @location_x         = 0
    @location_y         = 0
    @location_direction = :east

    puts "Running inside initialize..."
  end

  def get_location_x
    return @location_x
  end

  def get_location_y
    return @location_y
  end

  def get_location_direction
    return @location_direction
  end

  def set_location_x(location_x)
    @location_x = location_x
  end

  def set_location_direction(location_direction)
    @location_direction = location_direction
  end

  def set_location_y(location_y)
    @location_y = location_y
  end

  def go_left
    case self.get_location_direction
    when :south
      self.set_location_direction(:east)
    when :east
      self.set_location_direction(:north)
    when :north
      self.set_location_direction(:west)
    when :west
      self.set_location_direction(:south)
    end

    return self.get_location_direction
  end

  def go_right
    case self.get_location_direction
    when :south
      self.set_location_direction(:west)
    when :west
      self.set_location_direction(:north)
    when :north
      self.set_location_direction(:east)
    when :east
      self.set_location_direction(:south)
    end

    return self.get_location_direction
  end

  def move
    new_location_x     = self.get_location_x
    new_location_y     = self.get_location_y
    location_direction = self.get_location_direction

    case location_direction
    when :north
      new_location_y += 1
      unless new_location_y > 4
        self.set_location_y(new_location_y)
      end

    when :east
       new_location_x += 1
       unless new_location_x > 4
         self.set_location_x(new_location_x)
       end

    when :south
      new_location_y -= 1
      unless new_location_y < 0
        self.set_location_y(new_location_y)
      end

    when :west
      new_location_x -= 1
      unless new_location_x < 0
        self.set_location_x(new_location_x)
      end
    end

  end
end
