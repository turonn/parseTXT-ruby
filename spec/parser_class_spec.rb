require '../app/parser_class.rb'
require '../app/trip_class.rb'
require '../app/driver_class.rb'

RSpec.describe "Parser" do 
  file = nil

  after(:each) do
    file = File.open('testfile')
    File.delete(file)
  end

  describe ".parse" do
    before do
      file = File.open('testfile', 'w+')
    end
    context "with an empty file" do
      it "outputs nothing" do 
        expect{ Parser.parse(file) }.to output("").to_stdout
      end
    end

    context "with one driver and no miles" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write ("Driver Dan")
        end
        file = File.open('testfile')
      end
      it "outputs a single driver driving zero miles" do
        expect{ Parser.parse(file) }.to output("Dan: 0 miles\n").to_stdout
      end
    end
    
    context "with one driver who has an invalid trip of 100.01 mph" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write("Driver Dan\nTrip Dan 7:15 8:15 100.01")
        end
        file = File.open('testfile')
      end
      it "outputs a single driver driving zero miles" do
        expect{ Parser.parse(file) }.to output("Dan: 0 miles\n").to_stdout
      end
    end

    context "with one driver who has an invalid trip of 4.99 mph" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write("Driver Dan\nTrip Dan 7:15 8:15 4.99")
        end
        file = File.open('testfile')
      end
      it "outputs a single driver driving zero miles" do
        expect{ Parser.parse(file) }.to output("Dan: 0 miles\n").to_stdout
      end
    end
    
    context "with one driver who has driven a valid trip at 5 mph" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write("Driver Dan\nTrip Dan 06:12 07:12 5")
        end
        file = File.open('testfile')
      end
      it "outputs a driver with correct speed" do
        expect{ Parser.parse(file) }.to output("Dan: 5 miles @ 5 mph\n").to_stdout
      end
    end

    context "with one driver who has driven a valid trip at 100 mph" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write("Driver Dan\nTrip Dan 06:12 07:12 100")
        end
        file = File.open('testfile')
      end
      it "outputs a driver with correct speed" do
        expect{ Parser.parse(file) }.to output("Dan: 100 miles @ 100 mph\n").to_stdout
      end
    end

    context "with one driver who has driven multiple valid trips" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write("Driver Dan\nTrip Dan 07:15 07:45 17.3\nTrip Dan 06:12 06:32 21.8")
        end
        file = File.open('testfile')
      end
      it "outputs a driver with correct speed" do
        expect{ Parser.parse(file) }.to output("Dan: 39 miles @ 47 mph\n").to_stdout
      end
    end

    context "with multiple drivers driving a mix of valid/no trips" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write("Driver Dan\nTrip Dan 07:15 07:45 17.3\nTrip Dan 06:12 06:32 21.8\nDriver Lauren\nDriver Kumi\nTrip Lauren 12:01 13:16 42.0")
        end
        file = File.open('testfile')
      end
      it "sorts drivers by distance driven" do
        expect{ Parser.parse(file) }.to output("Lauren: 42 miles @ 34 mph\nDan: 39 miles @ 47 mph\nKumi: 0 miles\n").to_stdout
      end
    end
      
    context "with a mix of drivers driving invalid, valid, and no trips" do
      before do
        File.open('testfile', 'w+') do |f|
          f.write("Driver Dan\nTrip Dan 07:15 07:45 17.3\nTrip Dan 06:12 06:32 21.8\nDriver Lauren\nDriver Kumi\nTrip Lauren 12:01 13:16 42.0\nTrip Kumi 15:16 16:16 4.0\nTrip Dan 21:00 22:00 150.0")
        end
        file = File.open('testfile', 'r+')
      end
      it "sorts valid drivers and ignores trips that are invalid" do
        expect{ Parser.parse(file) }.to output("Lauren: 42 miles @ 34 mph\nDan: 39 miles @ 47 mph\nKumi: 0 miles\n").to_stdout
      end
    end
  end
end
