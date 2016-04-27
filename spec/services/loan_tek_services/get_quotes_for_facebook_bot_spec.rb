require "rails_helper"

describe LoanTekServices::GetQuotesForFacebookBot do
  describe "#call" do
    context "with invalid params" do
      let(:params) { {} }

      it "returns false" do
        expect(described_class.new(params).call).to be_falsy
      end
    end

    context "with valid params" do
      let(:params) do
        {
          "parameters" => {
            "zipcode" => "90212",
            "credit_score" => "730",
            "purpose" => "purchase",
            "property_value" => "560000",
            "usage" => "vacation_home",
            "property_type" => "sfh",
            "down_payment" => "100000",
            "mortgage_balance" => "300000"
          }
        }
      end

      it "returns true" do
        VCR.use_cassette("get quotes from LoanTek for Facebook Bot") do
          expect(described_class.new(params).call).to be_truthy
        end
      end
    end
  end
end