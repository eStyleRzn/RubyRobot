# Robot's body abstraction
class Buddy
  attr_accessor :x
  attr_accessor :y
  attr_accessor :orient

  # Buddy's facing orientation
  NORTH = 'NORTH'
  SOUTH = 'SOUTH'
  EAST = 'EAST'
  WEST = 'WEST'

  DIRECTIONS = [NORTH, EAST, SOUTH, WEST]

  LEFT = 0
  RIGHT = 1

  def initialize
    # Rotation states declared in from left to right direction
    # Buddy's position
    @x = @y = 0
    # Buddy's orientation
    @orient = NORTH
  end

  # Rotates buddy
  def spin(direction)
    o = @orient
    idx = DIRECTIONS.index(o)
    case direction
      when Buddy::LEFT then
        o = DIRECTIONS.at(idx - 1)
      when Buddy::RIGHT then
        o = DIRECTIONS.at((idx + 1) % DIRECTIONS.size)
    end
    @orient = o
  end
end
