require 'aasm'
require './app/buddy'
require './app/printer'
require './app/table'

# The class implements robot's behaviour and states. And also validates transitions from one state to the next one
class Actions
  include AASM

  COMMON_STATES = [:facing, :spinning, :reporting, :moving]

  def initialize
    @buddy = Buddy.new
    @printer = Printer.new
    @table = Table.new
  end

  aasm :whiny_transitions => false do
    state :placing, :initial => true
    state :facing
    state :spinning
    state :moving
    state :reporting

    # Declare transitions map
    event :place, :after => :do_place  do
      # Declare strict state - placing with the guard function that validates buddy's future position on the table
      transitions :from => [:reporting, :placing], :to => :placing, :guard => :valid_place?
    end

    event :face, :after => :do_orient do
      # Declare a strict transition from placing state to the acing one, because it is the one robot command
      transitions :from => [:placing], :to => :facing
    end

    event :spin, :after => :do_spin do
      # Declare transitions to spinning state
      transitions :from => COMMON_STATES, :to => :spinning
    end

    event :move , :after => :do_move do
      # Declare transitions to moving state
      transitions :from => COMMON_STATES, :to => :moving
    end

    event :report, :after => :do_print do
      # Declare transitions to reporting state
      transitions :from => COMMON_STATES, :to => :reporting
    end
  end

  # Validates x, y coordinates according to the table sizes
  def valid_place?(x, y)
    @table.validate_pos(x, y)
  end

  # Performs robot placement
  def do_place(x, y)
    @table.place(x, y, @buddy)
  end

  # Performs robot facing
  def do_orient(orientation)
    @buddy.orient = orientation
  end

  # Performs robot's state report
  def do_print
    @printer.exec(@buddy)
  end

  # Move the robot
  def do_move
    @table.move(@buddy)
  end

  # Spin the robot
  def do_spin(direction)
    @buddy.spin(direction)
  end

end
