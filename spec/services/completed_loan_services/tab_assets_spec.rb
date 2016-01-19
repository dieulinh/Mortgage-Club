require "rails_helper"

describe CompletedLoanServices::TabAssets do
  let!(:loan) { FactoryGirl.create(:loan_with_properties) }
  let!(:asset) { FactoryGirl.create(:asset, borrower: loan.borrower) }

  before(:each) do
    @loan_params = {
      assets: loan.borrower.assets,
      subject_property: loan.subject_property,
      rental_properties: loan.rental_properties,
      primary_property: loan.primary_property,
      own_investment_property: loan.own_investment_property
    }

    @service = CompletedLoanServices::TabAssets.new(@loan_params)
  end

  it "returns false with subject property nil" do
    @service.subject_property = nil
    expect(@service.call).to be_falsey
  end

  it "returns false with assets not valid" do
    @service.assets[0].institution_name = nil
    expect(@service.call).to be_falsey
  end

  it "returns false with renter properties not valid" do
    @service.own_investment_property = true
    @service.rental_properties.first.property_type = nil
    expect(@service.call).to be_falsey
  end

  it "returns true with valid values" do
    expect(@service.call).to be_truthy
  end

  describe "check assets completed" do
    it "returns false with asset not valid" do
      @service.assets[0].institution_name = nil
      expect(@service.assets_completed?).to be_falsey
    end

    it "returns true with assets valid" do
      expect(@service.assets_completed?).to be_truthy
    end
  end

  describe "check asset completed" do
    it "returns false with institution name nil" do
      asset.institution_name = nil
      expect(@service.asset_completed?(asset)).to be_falsey
    end

    it "returns false with asset type nil" do
      asset.asset_type = nil
      expect(@service.asset_completed?(asset)).to be_falsey
    end

    it "returns false with current balance nil" do
      asset.current_balance = nil
      expect(@service.asset_completed?(asset)).to be_falsey
    end

    it "returns true with valid values" do
      expect(@service.asset_completed?(asset)).to be_truthy
    end
  end

  describe "checks rental properties completed" do
    it "returns true with own investment property nil" do
      @service.own_investment_property = nil
      expect(@service.rental_properties_completed?).to be_truthy
    end

    it "returns true with own investment property false" do
      @service.own_investment_property = false
      expect(@service.rental_properties_completed?).to be_truthy
    end

    it "returns false with rental properties not valid" do
      @service.own_investment_property = true
      @service.rental_properties.first.property_type = nil
      expect(@service.rental_properties_completed?).to be_falsey
    end
  end

  describe "checks subject property completed" do
    before do
      @property = @service.subject_property
    end

    it "returns false with property type nil" do
      @property.property_type = nil
      expect(@service.property_completed?(@property)).to be_falsey
    end

    it "returns false with address nil" do
      @property.address = nil
      expect(@service.property_completed?(@property)).to be_falsey
    end

    it "returns false with usage nil" do
      @property.usage = nil
      expect(@service.property_completed?(@property)).to be_falsey
    end

    it "returns false with market price nil" do
      @property.market_price = nil
      expect(@service.property_completed?(@property)).to be_falsey
    end

    it "returns false with escrows nil" do
      @property.mortgage_includes_escrows = nil
      expect(@service.property_completed?(@property)).to be_falsey
    end

    it "returns false with estimated property tax nil" do
      @property.estimated_property_tax = nil
      expect(@service.property_completed?(@property)).to be_falsey
    end

    it "returns false with estimated hazard insurance nil" do
      @property.estimated_hazard_insurance = nil
      expect(@service.property_completed?(@property)).to be_falsey
    end

    it "returns true with valid values" do
      expect(@service.property_completed?(@property)).to be_truthy
    end
  end

  context "with valid primary property" do
    describe "checks primary property completed" do
      before do
        @property = @service.primary_property
      end

      it "returns false with property type nil" do
        @property.property_type = nil
        expect(@service.property_completed?(@property)).to be_falsey
      end

      it "returns false with address nil" do
        @property.address = nil
        expect(@service.property_completed?(@property)).to be_falsey
      end

      it "returns false with usage nil" do
        @property.usage = nil
        expect(@service.property_completed?(@property)).to be_falsey
      end

      it "returns false with market price nil" do
        @property.market_price = nil
        expect(@service.property_completed?(@property)).to be_falsey
      end

      it "returns false with escrows nil" do
        @property.mortgage_includes_escrows = nil
        expect(@service.property_completed?(@property)).to be_falsey
      end

      it "returns false with estimated property tax nil" do
        @property.estimated_property_tax = nil
        expect(@service.property_completed?(@property)).to be_falsey
      end

      it "returns false with estimated hazard insurance nil" do
        @property.estimated_hazard_insurance = nil
        expect(@service.property_completed?(@property)).to be_falsey
      end

      it "returns true with valid values" do
        expect(@service.property_completed?(@property)).to be_truthy
      end
    end
  end
end
