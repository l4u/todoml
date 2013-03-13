module Todoml
  class Tasks
    attr_accessor :velocity, :serialized
    def load(data)
      self.velocity = data['velocity']

      self.serialized = {}
      ['TODO', 'CURRENT'].each do |group|
        self.serialized[group] = data[group].flatten(1)
        self.serialized[group].reject! { |task_raw| 
          task_raw[0] == '(' ||
          task_raw[0] == ')'
        }
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
      count = 0
      unfinished_tasks.each_with_index do |task, index|
        velocity_left -= task.point
        if velocity_left < 0
          velocity_left = @velocity - task.point
          if current_group != 'TODO'
            current_group = 'TODO' 
            require_spacer = false
            count = 0
          else
            count += 1
          end
        end
        @tasks[current_group][count] ||= []
        @tasks[current_group][count] << task
      end
    end

    def format_task(key)
      self.serialized[key].map { |group|
        group.map { |task|
          task.to_s
        }
      }
    end

    def format_tasks_with_foldmarks(key)
      @fold_mark_start = Todoml::Task.new("- {")
      @fold_mark_end = Todoml::Task.new("- {")
      self.serialized[key].each { |group|
        group.unshift  "("
        group << ")"
      }
      self.serialized[key].map { |group|
        group.map { |task|
          if task.is_a? Task
            task.to_s
          else 
            task
          end
        }
      }
    end
  end
end
