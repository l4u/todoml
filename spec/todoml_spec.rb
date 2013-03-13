require 'spec_helper'
require 'yaml'
describe Todoml do
  it "should parse simple yaml" do
    YAML.load_file "./spec/data/simple.yaml"
  end

  describe "retrieve data" do
    before :each do
      @data = YAML.load_file "./spec/data/simple.yaml"
    end
    it "should retrieve velocity" do
      @data['velocity'].should eq 10
    end
  end
end
