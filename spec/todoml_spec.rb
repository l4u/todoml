require 'spec_helper'
require 'yaml'
describe Todoml do
  it "should parse simple yaml" do
    data = YAML.load_file "./spec/data/simple.yaml"
    p data
  end
end
