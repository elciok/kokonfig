RSpec.describe Kokonfig::Objectifier do
  it "convert hash to object" do
    result = Kokonfig::Objectifier.objectify({
      age: 57,
      name: "Joe Exotic",
      codes: [1, 2, 3],
      enemy: {
        name: "Carole Baskin",
        age: 59
      }
    })
    expect(result).not_to be nil
    expect(result.age).to eq(57)
    expect(result.name).to eq("Joe Exotic")
    expect(result.codes).to eq([1, 2, 3])
    expect(result.enemy.name).to eq("Carole Baskin")
    expect(result.enemy.age).to eq(59)
  end

end
