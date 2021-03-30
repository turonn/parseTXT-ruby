class Driver
  attr_accessor :name, :total_time, :total_miles, :avg_speed

  def self.all
    @all ||= []
  end

  def self.lookup(name)
    Driver.all.each do |driver|
      return driver if name == driver.name
    end
  end

  def self.sort
    @all = @all.sort_by { |driver| -driver.total_miles }
  end

  def initialize(name)
    @name = name
    @total_time = '0:0'
    @total_miles = 0
    @avg_speed = 0
    
    Driver.all << self
  end

  def add_miles(miles)
    @total_miles += miles.to_f
  end

  def add_time(time)
    arr = @total_time.split(':')
    totalHours = arr[0].to_i
    totalMinutes = arr[1].to_i

    arr2 = time.split(':')
    newHours = arr2[0].to_i
    newMinutes = arr2[1].to_i

    totalHours += newHours
    totalMinutes += newMinutes

    @total_time = "#{totalHours}:#{totalMinutes}"
  end

  def calculate_avg_speed
    unless @total_miles == 0 || @total_time.count('1-9') == 0
      timeArray = @total_time.split(':')
      timeArray[1] = timeArray[1].to_f / 60.0
      timeNum = timeArray[0].to_i + timeArray[1]

      @avg_speed = (@total_miles / timeNum).round()
    end
  end

end