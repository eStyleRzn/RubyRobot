# The class is the table surface abstraction
class Table

  def initialize
    # Define table sizes
    @size_x = 5
    @size_y = 5
  end

  # Places robot on the table
  def place(x, y, buddy)
    # Skip invalid states, when the buddy may fall down from the table
    if validate_pos(x, y)
      buddy.x = x
      buddy.y = y
    end
  end

  # Moves the robot one unit according the its current facing
  def move(buddy)
    x = buddy.x
    y = buddy.y

    case
      when buddy.orient == Buddy::NORTH then y += 1
      when buddy.orient == Buddy::SOUTH then y -= 1
      when buddy.orient == Buddy::EAST then x += 1
      when buddy.orient == Buddy::WEST then x -= 1
    end

    if validate_pos(x, y)
      # Set buddy position only if the future is valid
      buddy.x = x
      buddy.y = y
    end
  end

  # Validates coordinated according to table sizes
  def validate_pos(x, y)
    return x.between?(0, @size_x - 1) && y.between?(0, @size_y - 1)
  end
end
