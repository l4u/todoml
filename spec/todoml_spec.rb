require 'spec_helper'
require 'yaml'
describe Todoml do
  describe "task" do
    it "should be initialized with name and point" do
      task_raw = ["Task 1", 3]
      task = Todoml::Task.new(task_raw)
      task.name.should eq 'Task 1'
      task.point.should eq 3
    end

    it "should handle tasks in a single string with a default point 1" do
      task_raw = "Task single string"
      task = Todoml::Task.new(task_raw)
      task.name.should eq 'Task single string'
      task.point.should eq 1 
    end
  end

  it "should parse simple yaml" do
    YAML.load_file "./spec/data/simple.yaml"
  end

  describe "simple data" do
    before :each do
      @data = YAML.load_file "./spec/data/simple.yaml"
    end

    it "should retrieve velocity" do
      @data['velocity'].should eq 10
    end

    it "should retreve tasks" do
      @data['CURRENT'].count.should eq 1
      task_raw = @data['CURRENT'].first
      task = Todoml::Task.new(task_raw)
      task.name.should eq "User can read learn you some erlang"
      task.point.should eq 3
    end
  end

  describe "case 1" do
    before :each do
      @data = YAML.load_file "./spec/data/case1.yaml"
    end

    it "should parse unfinished tasks and convert them to a list of Tasks" do
      unfinished_tasks = @data['CURRENT'] + @data['TODO']
      unfinished_tasks.reject! { |task_raw| task_raw.nil? }
      unfinished_tasks.map! { |task_raw| 
        Todoml::Task.new(task_raw)
      }

      unfinished_tasks.count.should eq 11

      task = unfinished_tasks.first
      task.name.should eq "User can read learn you some erlang"
      task.point.should eq 3
    end
  end
end
