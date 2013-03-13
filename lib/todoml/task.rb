module Todoml
  class Task
    attr_accessor :name, :point

    def initialize(task_raw)
      if task_raw.is_a? String
        @name = task_raw
        @point = 1
      elsif task_raw.is_a? Array and task_raw.length == 2 and
        task_raw[0].is_a? String and task_raw[1].is_a? Numeric
        @name = task_raw[0]
        @point = task_raw[1]
      else 
        raise TypeError
      end

    end

    def to_a
      [name, point]
    end

    def to_yaml_simple
      if name.empty?
        ""
      else
        "[ #{name}, #{point} ]"
      end
    end

  end
end
