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

    it "should parse todo tasks and ignore spacers" do
      tasks = Todoml::Tasks.new 
      ['TODO', 'CURRENT', 'FINISHED'].each do |group|
        tasks[group] = @data[group]
        tasks[group].reject! { |task_raw| task_raw.nil? }
        tasks[group].map! { |task_raw| 
          Todoml::Task.new(task_raw)
        }
      end
      tasks['CURRENT'].count.should eq 1
      tasks['TODO'].count.should eq 10

      task = tasks['TODO'].first
      task.name.should eq "User can see the updated tasks grouped by interations"
      task.point.should eq 1

      tasks.to_yaml_simple.should eq File.read './spec/data/case1_removed_spacers.yaml'
    end
  end
end
