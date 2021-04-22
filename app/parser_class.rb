require_relative 'driver_class'
require_relative 'trip_class'

class Parser
  def self.parse(arg)
    #iterate through each line of the txt file and log Drivers & Trips
    #added simple else case to catch my own typos as I mocked data
    arg.each_line do |line|
      arr = line.split(' ')
      case arr[0]
        when "Driver"
          Driver.new(arr[1])
        when "Trip"
          Trip.new(arr[1], arr[2], arr[3], arr[4])
        else 
          puts "Syntax error in file for line - " + line
      end
    end

    #iterate through each trip
    #skipping passed trips that are too slow or fast
    #find the driver associated with that trip
    #add miles_driven and trip_time to that driver's total
    Trip.all.each do |trip|
      next if trip.trip_speed < 5 || trip.trip_speed > 100
      driver = Driver.lookup(trip.name)
      driver.add_miles(trip.miles_driven)
      driver.add_time(trip.trip_time)
    end

    #arrange all drivers in decending order based on miles driven
    Driver.sort

    #print out a solution for each driver in the suggested format
    #If they don't have any valid trips, show 0 miles and leave off @ avg_speed + mph
    Driver.all.each do |driver|
      unless driver.total_miles == 0
        driver.calculate_avg_speed
        puts "#{driver.name}: #{driver.total_miles.round()} miles @ #{driver.avg_speed} mph"
      else
        puts "#{driver.name}: 0 miles"
      end
    end

    #clear data to stop RSpec from throwing a fit about persisting data
    Driver.clear_data
    Trip.clear_data
  end
end