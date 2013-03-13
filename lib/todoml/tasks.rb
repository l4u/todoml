module Todoml
  class Tasks
    attr_accessor :velocity, :serialized
    def load(data)
      self.velocity = data['velocity']

      self.serialized = {}
      ['TODO', 'CURRENT'].each do |group|
        self.serialized[group] = data[group].flatten(1)
        self.serialized[group].reject! { |task_raw| task_raw.nil? }
        self.serialized[group].map! { |task_raw| 
          Todoml::Task.new(task_raw)
        }
      end
    end

    def regroup_current_and_todo!
      @tasks = self.serialized

      unfinished_tasks = @tasks['CURRENT'] + @tasks['TODO']
      @tasks['CURRENT'] = []
      @tasks['TODO'] = []

      current_group = 'CURRENT'
      velocity_left = @velocity
      require_spacer = false
      count = 0
      unfinished_tasks.each_with_index do |task, index|
        velocity_left -= task.point
        if velocity_left >= 0
          require_spacer = false
        else
          velocity_left = @velocity - task.point
          if current_group != 'TODO'
            current_group = 'TODO' 
            require_spacer = false
            count = 0
          else
            require_spacer = true
          end
        end
        count += 1 if require_spacer
        @tasks[current_group][count] ||= []
        @tasks[current_group][count] << task
      end
    end

    def simple_task(key)
      self.serialized[key].map { |group|
        group.map { |task|
          task.to_s
        }
      }
    end
  end
end
