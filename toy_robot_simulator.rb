require "./toy_robot_simulator.rb"

# this enable this ruby script to be run from the command line
if __FILE__ == $PROGRAM_NAME
  $VERBOSE = nil
  ToyRobotSimulator.new.main
end

class ToyRobotSimulator

  NORTH_DIRECTION = :north
  SOUTH_DIRECTION = :south
   EAST_DIRECTION = :east
   WEST_DIRECTION = :west

  def main
    location_x         = 0
    location_y         = 0
    location_direction = EAST_DIRECTION

    loop do
      entered_command = command("Command: ")
      break if entered_command[:command] != "PLACE"

      next if entered_command[:entered_x].nil?
      next if entered_command[:entered_y].nil?
      next if entered_command[:direction].nil?
      location_x, location_y, location_direction = place_robot(entered_command)
    end
    loop do
      entered_command = command("Command: ")
      case entered_command[:command]
      when "PLACE"
        next if entered_command[:entered_x].nil?
        next if entered_command[:entered_y].nil?
        next if entered_command[:direction].nil?
        location_x, location_y, location_direction = place_robot(entered_command)
      when "MOVE"
        location_x, location_y = move_it(location_x, location_y, location_direction)
      when "LEFT"
        location_direction = go_left(location_direction)
      when "RIGHT"
        location_direction = go_right(location_direction)
      when "REPORT"
        report_command(location_x, location_y, location_direction)
      when "QUIT"
        puts "quit command"
        break
      end
    end
  end

  def command(prompt)
    result = { command: nil, entered_x: nil, entered_y: nil, direction: nil }
    print prompt
    entry = gets.chomp.upcase
    if entry.include? "PLACE"
      arr = entry.split(/[\s,']/)
      result[:command  ] = arr[0]
      result[:entered_x] = arr[1]
      result[:entered_y] = arr[2]
      result[:direction] = arr[3]
    else
      arr = entry.split(/[\s,']/)
      result[:command] = arr[0]
    end
    return result
  end

  def place_robot(entered_command)
    location_x         = entered_command[:entered_x].to_i
    location_y         = entered_command[:entered_y].to_i
    location_direction = entered_command[:direction]
    return location_x, location_y, location_direction
  end

  def report_command(location_x, location_y, location_direction)
    puts "#{location_x}"
    puts "#{location_y}"
    puts "#{location_direction}"
  end

  def go_left(location_direction)
    case location_direction
    when SOUTH_DIRECTION
      return EAST_DIRECTION
    when EAST_DIRECTION
      return NORTH_DIRECTION
    when NORTH_DIRECTION
      return WEST_DIRECTION
    when WEST_DIRECTION
      return SOUTH_DIRECTION
    end
  end

  def go_right(location_direction)
    case location_direction
    when SOUTH_DIRECTION
      return WEST_DIRECTION
    when WEST_DIRECTION
      return NORTH_DIRECTION
    when NORTH_DIRECTION
      return EAST_DIRECTION
    when EAST_DIRECTION
      return SOUTH_DIRECTION
    end
  end

  def move_it(location_x, location_y, location_direction)
    new_location_y = location_y
    new_location_x = location_x
    case location_direction
    when NORTH_DIRECTION
      new_location_y += 1
      unless new_location_y > 4
        location_y = new_location_y
      end
    when EAST_DIRECTION
       new_location_x += 1
       unless new_location_x > 4
         location_x = new_location_x
       end
    when SOUTH_DIRECTION
      new_location_y -= 1
      unless new_location_y < 0
        location_y = new_location_y
      end
    when WEST_DIRECTION
      new_location_x -= 1
      unless new_location_x < 0
        location_x = new_location_x
      end
    end
    return location_x, location_y
  end


end
