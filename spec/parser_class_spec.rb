require '../app/parser_class.rb'
require '../app/trip_class.rb'
require '../app/driver_class.rb'

RSpec.describe "Parser" do 
  describe ".parse" do
    it "solves the example text" do 
      expect(Parser.parse(/rootExample2.txt)).to be
    end
  end
end
