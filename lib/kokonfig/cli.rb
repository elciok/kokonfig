module Kokonfig
  CONFIG_DIR = "config/kokonfig"
  DATA_DIR = "data"
  TEMPLATES_DIR = "templates"

  module CLI
    def self.start
      current_dir = Rails.root rescue Dir.pwd
      data_dir = File.join(current_dir, CONFIG_DIR, DATA_DIR)
      templates_dir = File.join(current_dir, CONFIG_DIR, TEMPLATES_DIR)
      output_dir = current_dir

      Dir.glob("#{data_dir}/**/*.yml").each do |data_file_path|
        data_file = Kokonfig::DataFile.new(data_file_path, data_dir, templates_dir)
        data_file.generate_files(output_dir)
      end
    end
  end
end