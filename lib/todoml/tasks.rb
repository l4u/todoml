module Todoml
  class Tasks < Hash
    attr_accessor :other_yaml
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
  end
end
