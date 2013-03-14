require 'spec_helper'
require 'yaml'
describe Todoml do
  describe "task" do
    it "should be initialized with name and point" do
      task_raw = "3 - Task 1"
      task = Todoml::Task.new(task_raw)
      task.name.should eq 'Task 1'
      task.point.should eq 3
    end
  end

  describe "case 1" do
    before :each do
      @data = YAML.load_file "./spec/data/case1.yaml"
      @tasks = Todoml::Tasks.new
      @tasks.load @data
    end

    it "should load data and retrieve velocity" do
      @tasks.velocity.should eq 5
    end

    it "should retreve tasks" do
      @tasks.serialized['CURRENT'].count.should eq 1
      @tasks.serialized['TODO'].count.should eq 11
    end

    it "should be able to regroup CURRENT and TODO" do
      @tasks.regroup_current_and_todo!
      @data['TODO'] = @tasks.format_task("TODO")
      @data['CURRENT'] = @tasks.format_task("CURRENT")
      @data.to_yaml.should eq File.read './spec/data/case1_results.yaml'
    end

    it "should be able to regroup CURRENT and TODO with foldmarks" do
      @tasks.regroup_current_and_todo!
      @data['TODO'] = @tasks.format_tasks_with_foldmarks("TODO")
      @data['CURRENT'] = @tasks.format_tasks_with_foldmarks("CURRENT")
      @data.to_yaml.should eq File.read './spec/data/case1_results_foldmark.yaml'
    end
  end
end
