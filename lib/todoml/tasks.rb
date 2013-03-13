module Todoml
  class Tasks < Hash
    attr_accessor :other_yaml
    def to_yaml_simple
      other_yaml.to_yaml + 
      "CURRENT:\n" +
        self['CURRENT'].map { |task| "    - " + task.to_yaml_simple}.join("\n") +
        "\n" +
        "\n" +
        "TODO:\n" +
        self['TODO'].map { |task| "    - " + task.to_yaml_simple}.join("\n") +
        "\n" +
        "\n" +
        "FINISHED:\n" +
        self['FINISHED'].map { |task| "    - " + task.to_yaml_simple}.join("\n") +
        "\n"
    end
  end
end
