module Todoml
  class Task
    attr_accessor :name, :point

    def initialize(task_raw)
      parts = task_raw.split '-', 2
      if parts.length == 2
        @point = parts[0].to_i
        @name = parts[1].lstrip
      else
        raise TypeError
      end
    end

    def to_s
      "#{point} - #{name}"
    end

  end
end
