require './app/actions.rb'

module Processor

  def process_command actions, cmd
    # Declare regular expression to validate PLACE command syntax
    regexp = "PLACE -?\\d+,-?\\d+,(#{Buddy::DIRECTIONS.join('|')})"

    if !(Regexp.new(regexp).match(cmd).nil?)
      # Tokenize PLACE command to extract its X, Y, FACING parameters
      x = cmd.slice(/-?\d+/)
      y = cmd.slice(/(,-?\d+)/).slice(/-?\d+/)
      facing = cmd.slice(Regexp.new(Buddy::DIRECTIONS.join('|')))

      # Process PLACE command
      actions.place(x.to_i, y.to_i)
      actions.face(facing)
    else
      # Process the rest commands
      case cmd
        when 'MOVE' then actions.move
        when 'LEFT' then actions.spin(Buddy::LEFT)
        when 'RIGHT' then actions.spin(Buddy::RIGHT)
        when 'REPORT' then actions.report
      end

    end
  end

  extend self

end
