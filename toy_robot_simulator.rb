require "./toy_robot_simulator.rb"
require "./toy_robot.rb"

# this enable this ruby script to be run from the command line
if __FILE__ == $PROGRAM_NAME
  $VERBOSE = nil
  toy_robot_simulator = ToyRobotSimulator.new
  toy_robot_simulator.main
end

class ToyRobotSimulator

  NORTH_DIRECTION = :north
  SOUTH_DIRECTION = :south
   EAST_DIRECTION = :east
   WEST_DIRECTION = :west

  def initialize
    @toy_robot = ToyRobot.new
  end

  def main
    location_x         = 0
    location_y         = 0
    location_direction = EAST_DIRECTION

=begin
    loop do
      entered_command = command("Command: ")
puts "#{entered_command.inspect}"
      break if entered_command[:command] != "PLACE"

      next if entered_command[:entered_x].nil?
      next if entered_command[:entered_y].nil?
      next if entered_command[:direction].nil?
      if  entered_command[:entered_x].to_i == 0 && entered_command[:entered_y].to_i == 0
        @toy_robot.set_location_x(0)
        @toy_robot.set_location_y(0)
        @toy_robot.set_location_direction(entered_command[:direction])
        report_command
        break
      end
    end
=end
    loop do
      entered_command = command("Command: ")
      case entered_command[:command]
      when "PLACE"
        next if entered_command[:entered_x].nil?
        next if entered_command[:entered_y].nil?
        next if entered_command[:direction].nil?
        place_robot(entered_command)

      when "MOVE"
        @toy_robot.move
        report_command

      when "LEFT"
        @toy_robot.go_left
        report_command

      when "RIGHT"
        @toy_robot.go_right
        report_command

      when "REPORT"
        report_command

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
    @toy_robot.set_location_x(entered_command[:entered_x].to_i)
    @toy_robot.set_location_y(entered_command[:entered_y].to_i)
    @toy_robot.set_location_direction(entered_command[:direction])
    report_command
  end

  def report_command
    puts "x: #{     @toy_robot.get_location_x        }"
    puts "y: #{     @toy_robot.get_location_y        }"
    puts "Facing: #{@toy_robot.get_location_direction}"
  end
end
