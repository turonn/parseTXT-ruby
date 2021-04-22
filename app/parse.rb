require_relative 'parser_class'

#ARGF takes all ARGV elements as filenames
Parser.parse(ARGF)

#%miles on the highway
#trip is highway if speed >= 50
#Dan: 47 miles @ 47 mph 0% on hwy
#only on drivers who have driven
#Trip.highway?
#Driver add, if highway add to hwy_miles
