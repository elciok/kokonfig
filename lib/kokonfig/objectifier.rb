require "ostruct"

module Kokonfig::Objectifier
  def self.objectify(input)
    result = input
    if input.is_a? Hash
      input.each do |key, value|
        input[key] = Kokonfig::Objectifier.objectify(value)
      end
      result = OpenStruct.new(input)
    elsif input.is_a? Array
      input.each_with_index do |value, index|
        input[index] = Kokonfig::Objectifier.objectify(value)
      end
    end
    result
  end
end