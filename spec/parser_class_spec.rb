require '../app/parser_class.rb'
require '../app/trip_class.rb'
require '../app/driver_class.rb'
require 'tempfile'

RSpec.describe "Parser" do 
  let(:file) { Tempfile.new(['testfile', '.txt']) }

  after do
    file.unlink
  end

  describe ".parse" do
    it "outputs nothing with a blank file" do 
      expect{ Parser.parse(file) }.to output("").to_stdout
    end

    it "outputs a single driver driving zero miles" do
      file.write("Driver Dan")
      file.rewind
      expect{ Parser.parse(file) }.to output("Dan: 0 miles\n").to_stdout
    end

    it "outputs a driver with correct speed" do
      #this adds to the previously written file
      file.write("Trip Dan 07:15 07:45 17.3\nTrip Dan 06:12 06:32 21.8")
      file.rewind
      expect{ Parser.parse(file) }.to output("Dan: 39 miles @ 47 mph\n").to_stdout
    end

    it "sorts multiple drivers by distance driven" do
      file.write("\nDriver Lauren\nDriver Kumi\nTrip Lauren 12:01 13:16 42.0")
      file.rewind
      expect{ Parser.parse(file) }.to output("Lauren: 42 miles @ 34 mph\nDan: 39 miles @ 47 mph\nKumi: 0 miles\n").to_stdout
    end

    it "ignores trips that are over 100mph" do
      file.write("Trip Kumi 15:16 16:16 105")
      file.rewind
      expect{ Parser.parse(file) }.to output("Lauren: 42 miles @ 34 mph\nDan: 39 miles @ 47 mph\nKumi: 0 miles\n").to_stdout
    end
  end
end
