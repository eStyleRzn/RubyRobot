require './app/processor'

total_test_count = 0
total_success_test_count = 0

def simple_test commands, result
  actions = Actions.new
  commands = commands.split('/') if commands.is_a?(String)
  commands.each { |cmd| Processor.process_command(actions, cmd) }
  actions.instance_eval { @printer.report(@buddy) == result }
end

[
  ['LEFT/LEFT/PLACE 2,2,WEST/MOVE/MOVE/MOVE/MOVE', '0,2,WEST'],
  ['PLACE 1,2,EAST/MOVE/MOVE/LEFT/MOVE', '3,3,NORTH'],
  ['PLACE 4,0,EAST/MOVE/MOVE/RIGHT/MOVE', '4,0,SOUTH'],
  ['PLACE 0,0,NORTH/MOVE/MOVE/PLACE 3,5,SOUTH', '0,2,NORTH'],
].each_with_index do |e, i|
  total_test_count += 1
  ok = simple_test(e[0], e[1])
  puts "Simple test ##{i}: #{ok ? 'success' : 'fail'}"
  total_success_test_count += 1 if ok
end


puts "Complete: #{total_success_test_count}/#{total_test_count} successed!"
