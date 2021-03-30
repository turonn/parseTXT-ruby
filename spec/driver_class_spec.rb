require '../app/Driver_class.rb'

RSpec.describe "Driver" do 
  subject { Driver.new("testName") }

  describe 'initialize' do
    it "initializes instance variables" do
      expect(subject.total_time).to eq('0:0')
      expect(subject.total_miles).to eq(0)
      expect(subject.avg_speed).to eq(0)
    end
    it 'adds each new instance to the self.all array' do
      expect(Driver.all.count).to eq(1)
      Driver.new('testBob')
      expect(Driver.all.count).to eq(2)
    end
  end

  describe "add_time" do
    it "adds the correct time to existing time" do
      subject.total_time = '1:15'
      subject.add_time('1:01')
      expect(subject.total_time).to eq('2:16')
    end
    it "handles zero hours and zero minutes" do
      subject.total_time = '0:00'
      subject.add_time('0:1')
      expect(subject.total_time).to eq('0:1')

      subject.total_time = '0:00'
      subject.add_time('1:00')
      expect(subject.total_time).to eq('1:0')
    end
  end

  describe 'add_miles' do
    it "adds correct miles to existing miles" do
      subject.total_miles = 13
      subject.add_miles(12)
      expect(subject.total_miles).to eq(25)
    end
    it 'can handle floats' do
      subject.total_miles = 12.3
      subject.add_miles(21.9)
      expect(subject.total_miles).to eq(34.2)
    end
  end

  describe 'calculate_avg_speed' do
    it 'calculates the speed of non-zero numbers' do
      subject.total_miles = 45
      subject.total_time = '1:0'
      subject.calculate_avg_speed
      expect(subject.avg_speed).to eq(45)
    end
    it 'rounds the calculated speed of non-zero numbers to the nearest intiger' do
      subject.total_miles = 42
      subject.total_time = '1:15'
      subject.calculate_avg_speed
      expect(subject.avg_speed).to eq(34)
    end
    it 'ignores cases where total_miles' do
      subject.total_miles = 0
      subject.total_time = '1:15'
      subject.calculate_avg_speed
      expect(subject.avg_speed).to be_zero
    end
    it 'ignores cases where total_time is zero' do
      subject.total_miles = 45
      subject.total_time = '0:0'
      subject.calculate_avg_speed
      expect(subject.avg_speed).to be_zero
    end
  end

  describe "self.lookup" do
    it 'returns the record when given the driver name' do
      Jill = Driver.new("Jill")
      Jill.total_miles = 10
      Snyder = Driver.new("Snyder")
      Snyder.total_miles = 23
      Rambo = Driver.new("Rambo")
      Rambo.total_miles = 14

      expect(Driver.lookup("Snyder")).to eq(Snyder)
    end
  end

  # describe 'self.sort' do
  #   it 'sorts records in decending order by total_miles' do
  #     Jill = Driver.new("Jill")
  #     Jill.total_miles = 10
  #     Snyder = Driver.new("Snyder")
  #     Snyder.total_miles = 23
  #     Rambo = Driver.new("Rambo")
  #     Rambo.total_miles = 14

  #     expect(Driver.sort).to match_array([
  #       Snyder,
  #       Rambo,
  #       Jill      
  #     ])
  #   end
  # end
end