module Todoml
  class Tasks < Hash
    attr_accessor :other_yaml, :velocity
    def load(data)
      self.velocity = data['velocity']
      other_yaml = data.clone
      ['TODO', 'CURRENT', 'FINISHED'].each do |group|
        other_yaml.reject!{ |key| key == group }
      end
      self.other_yaml = other_yaml

      ['TODO', 'CURRENT', 'FINISHED'].each do |group|
        self[group] = data[group]
        self[group].reject! { |task_raw| task_raw.nil? }
        self[group].map! { |task_raw| 
          Todoml::Task.new(task_raw)
        }
      end
    end

    def to_yaml_simple
      results = other_yaml.to_yaml
      ['CURRENT', 'TODO', 'FINISHED'].each do |group|
        results << "#{group}:\n"
        results << self[group].map { |task| 
          "    - " + task.to_yaml_simple
        }.join("\n")
        results << "\n"
        results << "\n" if group != 'FINISHED'
      end
      results
    end

    def regroup_current_and_todo!
      @tasks = self
      unfinished_tasks = @tasks['CURRENT'] + @tasks['TODO']
      @tasks['CURRENT'] = []
      @tasks['TODO'] = []
      current_group = 'CURRENT'
      velocity_left = @velocity
      require_spacer = false
      unfinished_tasks.each_with_index do |task, index|
        velocity_left -= task.point
        if velocity_left >= 0
          require_spacer = false
        else
          velocity_left = @velocity - task.point
          if current_group != 'TODO'
            current_group = 'TODO' 
            require_spacer = false
          else
            require_spacer = true
          end
        end
        self[current_group] << Todoml::Task.new("") if require_spacer 
        self[current_group] << task
      end
    end

  end
end
