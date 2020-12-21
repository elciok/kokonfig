RSpec.describe Kokonfig::DataFile do
  let(:data_file) do
    Kokonfig::DataFile.new("/var/local/myapp/data/config.txt.yml", "/var/local/myapp/data", "/var/local/myapp/templates")
  end

  it "computes template file path" do
    expect(data_file.template_path).to eq("/var/local/myapp/templates/config.txt.erb")
  end

  it "computes base result file" do
    expect(data_file.base_result_file).to eq("config.txt")
  end

  it "computes result filename from version string name" do
    expect(data_file.result_file("production")).to eq("config.production.txt")
  end

  it "computes relative path from data dir to file" do
    expect(data_file.base_result_relative_path.to_s).to eq(".")

    deeper_path_file = Kokonfig::DataFile.new("/config/data/more/dirs/config.txt.yml", "/config/data", "/config/templates")
    expect(deeper_path_file.base_result_relative_path.to_s).to eq("more/dirs")
  end

  context "generate_files" do
    DIR_OUTPUT = "./tmp/data_file_spec"

    before(:each) do
      FileUtils.remove_entry_secure(DIR_OUTPUT) rescue nil
      FileUtils.mkdir_p(DIR_OUTPUT)

      dir_config = File.join(Dir.pwd, "spec/fixtures/files/data_file")
      dir_data = File.join(dir_config, "data")
      dir_templates = File.join(dir_config, "templates")
      file_path = File.join(dir_data, "myconfig/result.txt.yml")

      data = Kokonfig::DataFile.new(file_path, dir_data, dir_templates)
      data.generate_files(DIR_OUTPUT)
    end

    after(:each) do
      FileUtils.remove_entry_secure(DIR_OUTPUT) rescue nil
    end

    it "creates directory" do
      expect(Dir.exists?("./tmp/data_file_spec/myconfig")).to eq(true)
    end

    it "creates files" do
      expect(File.exists?("./tmp/data_file_spec/myconfig/result.development.txt"))
      expect(File.exists?("./tmp/data_file_spec/myconfig/result.production.txt"))
    end

    it "fills templates with file data from corresponding version" do
      expect(File.read("./tmp/data_file_spec/myconfig/result.development.txt")).to eq("My favorite color is purple and my ID is 89765.")
      expect(File.read("./tmp/data_file_spec/myconfig/result.production.txt")).to eq("My favorite color is red and my ID is 2.")
    end
  end
end