require_relative 'driver_class'
require_relative 'trip_class'
require_relative 'parser_class'

#ARGF takes all ARGV elements as filenames
Parser.parse(ARGF)