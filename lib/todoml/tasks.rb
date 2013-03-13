module Todoml
  class Tasks < Hash

    def to_yaml_simple
      "vim: fdm=indent\nvelocity: 5\n" +
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
