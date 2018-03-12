# Report abstraction class. Basicly implemented to skip duplicated output if the robot's previous position
# report is the same as the current one
class Printer
  def initialize
    # Previous output
    @@prev_value = ''
  end

  def report(buddy)
    "#{buddy.x},#{buddy.y},#{buddy.orient}"
  end

  def exec(buddy)
    puts report(buddy)
  end
end
