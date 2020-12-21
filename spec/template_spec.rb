RSpec.describe Kokonfig::Template do
  it "generate string from template and input data" do
    template = Kokonfig::Template.new("made in <%= country_name %>")
    data = {
      country_name: "China"
    }
    expect(template.apply(data)).to eq("made in China")
  end
end