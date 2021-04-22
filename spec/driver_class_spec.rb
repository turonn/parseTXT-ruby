require '../app/driver_class.rb'

RSpec.describe "Driver" do 
  subject { Driver.new("testName") }

  describe '#initialize' do
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
    it "initalizes a hwy_miles variable" do
      expect(subject.hwy_miles).to eq(0)
    end
    it "initalizes a hwy_percentage variable as 0" do
      expect(subject.hwy_percentage).to eq(0)
    end
  end

  describe "#add_time" do
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

  describe '#add_miles' do
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

  describe '#calculate_avg_speed' do
    it 'calculates the speed of non-zero numbers' do
      subject.total_miles = 45
      subject.total_time = '1:0'
      subject.calculate_avg_speed
      expect(subject.avg_speed).to eq(45)
    end
    context "when given non-round non-zero numbers" do
      it 'rounds the calculated speed to the nearest intiger' do
        subject.total_miles = 42
        subject.total_time = '1:15'
        subject.calculate_avg_speed
        expect(subject.avg_speed).to eq(34)
      end
    end
    context "when total_miles = 0" do
      it 'ignores the case and outputs zero' do
        subject.total_miles = 0
        subject.total_time = '1:15'
        subject.calculate_avg_speed
        expect(subject.avg_speed).to be_zero
      end
    end
    context "when total_time = 0:0" do
      it 'ignores the case and outputs zero' do
        subject.total_miles = 45
        subject.total_time = '0:0'
        subject.calculate_avg_speed
        expect(subject.avg_speed).to be_zero
      end
    end
  end

  describe ".lookup" do
    context "when given the driver name" do
      it 'returns the associated record' do
        jill = Driver.new("Jill")
        jill.total_miles = 10
        snyder = Driver.new("Snyder")
        snyder.total_miles = 23
        rambo = Driver.new("Rambo")
        rambo.total_miles = 14
        
        expect(Driver.lookup("Snyder")).to eq(snyder)
      end
    end
  end

  describe '.sort' do
    it 'sorts records in decending order by total_miles' do
      jessica = Driver.new("Jessica")
      jessica.total_miles = 100
      omar = Driver.new("Omar")
      omar.total_miles = 230
      achmed = Driver.new("Achmed")
      achmed.total_miles = 140

      expect(Driver.sort).to start_with(
        omar,
        achmed,
        jessica
      )
      expect(Driver.sort).not_to start_with(
        jessica,
        omar,
        achmed
      )
    end
  end

  describe '.clear_data' do
    it 'empties the contents of the @all class variable' do
      expect(Driver.all).not_to be_empty
      Driver.clear_data
      expect(Driver.all).to be_empty
    end
  end

  describe '.add_to_highway_miles' do
    it "adds givne miles to hwy_miles" do
      subject.hwy_miles = 0
      subject.add_to_highway_miles(10)
      expect(subject.hwy_miles).to eq(10)
    end
  end

  describe '.calculate_hwy_percentage' do
    context "when total miles and highway miles are non-zero numbers" do
      it "calculates the percentge of time on highway" do
        subject.total_miles = 100
        subject.hwy_miles = 50
        subject.calculate_hwy_percentage
        expect(subject.hwy_percentage).to eq(50)
      end
    end
    context "when total miles == 0" do
      it "returns 0" do
        subject.hwy_miles = 100
        subject.total_miles = 0
        subject.calculate_hwy_percentage
        expect(subject.hwy_percentage).to eq(0)
      end
    end
  end
end