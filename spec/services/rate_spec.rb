require 'rails_helper'

describe Rate do
  context "get_rates" do
    it "should convert correctly" do
      rates = Rate.get_rates
      expect(rates).to be_a(Array)
    end
  end

  context "get_fee" do
    it "should return an array of hash" do
      fee = Rate.get_fee
      expect(fee).to be_a(Array)
    end
  end

  context "convert_text_to_boolean" do
    it "should convert correctly" do
      expect(Rate.convert_text_to_boolean('False')).to eq(false)
      expect(Rate.convert_text_to_boolean('True')).to eq(true)
    end
  end
end