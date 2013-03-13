require 'spec_helper'
require 'yaml'
describe Todoml do
  describe "task" do
    it "should be initialized with name and point" do
      task = Todoml::Task.new({name: 'Task 1', point: 3})
      task.name.should eq 'Task 1'
      task.point.should eq 3
    end

    it "should have a default value of point 1" do
      task = Todoml::Task.new({name: 'Task lazy'})
      task.name.should eq 'Task lazy'
      task.point.should eq 1 
    end
  end

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

    it "should retreve tasks" do
      @data['CURRENT'].count.should eq 1
      task = @data['CURRENT'].first
      task[0].should eq "User can read learn you some erlang"
      task[1].should eq 3
    end
  end
end
