require 'optparse'
require './app/processor'

ARGV << '-h' if ARGV.empty?

# Define command line options to run the program
options = {}

# Parse command line
OptionParser.new do |opts|
  opts.banner = "Locomote robot usage: #{__FILE__} [options]"

  opts.on('-f', '--filename FILENAME", "Required robot commands input file') do |fname|
    if File.exist?(fname) && File.readable?(fname)
      options[:fname] = fname
    else
      puts "Can't read file #{fname}"
      exit
    end
  end

  opts.on '-h', '--help', 'Print this help' do
    puts opts
    exit
  end

end.parse!

if options.key?(:fname)

  # Create robot's actions object
  actions = Actions.new

  # Read input file line by line and process the commands
  File.readlines(options[:fname]).each { | line | Processor.process_command(actions, line.strip) }

else
  puts 'Required robot commands input file was not specified'
end
