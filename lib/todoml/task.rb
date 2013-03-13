module Todoml
  class Task
    attr_accessor :name, :point

    def initialize(params = {})
      @name = params.fetch :name
      @point = params.fetch :point, 1
    end
  end
end
