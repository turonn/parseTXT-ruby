require '../app/trip_class.rb'

RSpec.describe "Trip" do
  subject { Trip.new('testDan', '1:15', '2:15', 45) }

  describe '#initialize' do
    it 'transfers data from input to instance variables' do
      expect(subject.name).to eq('testDan')
      expect(subject.start_time).to eq('1:15')
      expect(subject.end_time).to eq('2:15')
      expect(subject.miles_driven).to eq(45)
    end
    it 'adds each new instance to the self.all array' do
      expect(Trip.all.count).to eq(1)
      Trip.new('testBob', '1:15', '2:15', 45)
      expect(Trip.all.count).to eq(2)
    end
    it 'calls calculate_time and sets trip_time' do
      expect(subject.trip_time).to be
    end
    it 'calls calculate_speed and sets trip_speed' do
      expect(subject.trip_speed).to be
    end
  end

  describe '#calculate_time' do
    it 'calculates the time of a trip' do
      expect(subject.trip_time).to eq('1:0')
      subject.start_time = "1:00"
      subject.end_time = "11:10"
      expect(subject.calculate_time).to eq('10:10')
    end
    it 'handles converting -minutes to fewer hours' do
      subject.start_time = "13:59"
      subject.end_time = "14:19"
      expect(subject.calculate_time).to eq('0:20')
    end
  end

  describe '#calculate_speed' do
    it 'calculates speed correctly' do
      subject.trip_time = "1:00"
      subject.miles_driven = 45
      expect(subject.calculate_speed).to eq(45)
    end
    it 'can handle rounding to the hundreths' do
      subject.trip_time = "0:59"
      subject.miles_driven = 45
      expect(subject.calculate_speed).to eq(45.76)
    end
  end
end