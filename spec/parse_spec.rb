require '../app/parse.rb'
require '../app/trip_class.rb'
require '../app/driver_class.rb'

RSpec.describe "parse" do 
  describe "ARGF.each_line" do
    it "registers Driver inputs as new Drivers" do 
      expect(ruby ./app/parse.rb rootExample2.txt).to be
    end
  end
end
