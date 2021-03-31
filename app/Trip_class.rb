class Trip
  attr_accessor :name, :start_time, :end_time, :trip_time, :miles_driven, :trip_speed

  def self.all
    @all ||= []
  end

  def initialize(name, start_time, end_time, miles_driven)
    @name = name
    @start_time = start_time
    @end_time = end_time
    @miles_driven = miles_driven

    calculate_time
    calculate_speed
    
    Trip.all << self
  end

  def calculate_time
    start_array = @start_time.split(':')
    end_array = @end_time.split(':')

    total_min = end_array[1].to_i - start_array[1].to_i
    total_hr = end_array[0].to_i - start_array[0].to_i

    if total_min < 0
      total_hr -= 1
      total_min += 60
    end

    @trip_time = "#{total_hr}:#{total_min}"
  end

  def calculate_speed
    time = @trip_time.split(':')
    time[1] = time[1].to_f / 60.0
    time_num = time[0].to_i + time[1]

    @trip_speed = (@miles_driven.to_f / time_num).round(2)
  end

end