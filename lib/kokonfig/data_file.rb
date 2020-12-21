require 'yaml'
require 'pathname'
require 'fileutils'

module Kokonfig
  class DataFile
    def initialize(data_file_path, data_dir, templates_dir)
      @path = data_file_path
      @data_dir = data_dir
      @templates_dir = templates_dir
    end

    def template_path
      path_parts = []
      path_parts << @templates_dir

      path_parts << base_result_relative_path if base_result_relative_path.to_s != "."

      template_file_name = "#{base_result_file}.erb"
      path_parts << template_file_name

      File.join(*path_parts)
    end

    def result_file(version)
      path_parts = []
      path_parts << base_result_relative_path if base_result_relative_path.to_s != "."

      result_base_file_extension = File.extname(base_result_file)
      result_base_file_name = File.basename(base_result_file, result_base_file_extension)
      result_file_name = "#{result_base_file_name}.#{version}#{result_base_file_extension}"
      path_parts << result_file_name

      File.join(*path_parts)
    end

    def base_result_file
      @base_result_file or @base_result_file = File.basename(@path, ".yml")
    end

    def base_result_relative_path
      @base_result_relative_path or @base_result_relative_path = Pathname.new(@path).relative_path_from(@data_dir).dirname
    end

    def generate_files(output_dir)
      template = Kokonfig::Template.from_file(self.template_path)

      data_per_version = YAML.load_file(@path)      
      data_per_version.each do |version, data|
        data = data.merge({version: version})
        rendered_data = template.apply(data)

        FileUtils.mkdir_p(File.join(output_dir, self.base_result_relative_path))

        output_path = File.join(output_dir, self.result_file(version))
        File.open(output_path, 'w+') do |result_file|
          result_file.write(rendered_data)
        end
      end
    end

  end
end