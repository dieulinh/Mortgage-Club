require "rails_helper"

describe BotNotificationServices::NotifyRateAlert do
  describe ".call" do
    before(:each) do
      @sign_up_info = {
        "result" => {
          "parameters" => {
            "purpose" => "refinance",
            "email" => "hoa@example.com"
          }
        }
      }
    end

    context "when params are valid" do
      it "notifies loan member about Rate Alert information" do
        described_class.call(@sign_up_info)
        expect(Delayed::Job.count).to eq(1)
      end
    end

    context "when params are invalid" do
      it "does not notify loan member about Rate Alert information" do
        @sign_up_info["result"] = nil
        described_class.call(@sign_up_info)
        expect(Delayed::Job.count).to eq(0)
      end
    end
  end
end
