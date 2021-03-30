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
    startArray = @start_time.split(':')
    endArray = @end_time.split(':')

    totalMin = endArray[1].to_i - startArray[1].to_i
    totalHr = endArray[0].to_i - startArray[0].to_i

    if totalMin < 0
      totalHr -= 1
      totalMin += 60
    end

    @trip_time = "#{totalHr}:#{totalMin}"
  end

  def calculate_speed
    time = @trip_time.split(':')
    time[1] = time[1].to_f / 60.0
    timeNum = time[0].to_i + time[1]

    @trip_speed = (@miles_driven.to_f / timeNum).round(2)
  end

end