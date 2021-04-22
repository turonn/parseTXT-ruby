class Driver
  attr_accessor :name, :total_time, :total_miles, :avg_speed, :hwy_miles, :hwy_percentage

  def self.all
    @all ||= []
  end

  def self.clear_data
    @all = []
  end

  def self.lookup(name)
    Driver.all.each do |driver|
      return driver if name == driver.name
    end
  end

  def self.sort
    @all ||= []
    @all = @all.sort_by { |driver| -driver.total_miles }
  end

  def initialize(name)
    @name = name
    @total_time = '0:0'
    @total_miles = 0
    @avg_speed = 0
    @hwy_miles = 0
    @hwy_percentage = 0
    
    Driver.all << self
  end

  def add_miles(miles)
    @total_miles += miles.to_f
  end

  def add_to_highway_miles(miles)
    @hwy_miles += miles.to_f
  end

  def add_time(time)
    arr = @total_time.split(':')
    total_hours = arr[0].to_i
    total_minutes = arr[1].to_i

    arr2 = time.split(':')
    new_hours = arr2[0].to_i
    new_minutes = arr2[1].to_i

    total_hours += new_hours
    total_minutes += new_minutes

    @total_time = "#{total_hours}:#{total_minutes}"
  end

  def calculate_avg_speed
    unless @total_miles == 0 || @total_time.count('1-9') == 0
      time_array = @total_time.split(':')
      time_array[1] = time_array[1].to_f / 60.0
      time_num = time_array[0].to_i + time_array[1]
      @avg_speed = (@total_miles / time_num).round()
    end
  end

  def calculate_hwy_percentage
    return 0 if @total_miles == 0
    @hwy_percentage = ((@hwy_miles.to_f / @total_miles.to_f)*100).round
  end

end