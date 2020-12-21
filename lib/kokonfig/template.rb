require "erb"

module Kokonfig
  class Template

    def initialize(templateString)
      @template = templateString
    end

    def self.from_file(path)
      template = File.read(path)
      Kokonfig::Template.new(template)
    end

    def apply(data)
      object = Kokonfig::Objectifier.objectify(data)
      ERB.new(@template, nil, '-').result(object.instance_eval { binding })
    end

  end
end