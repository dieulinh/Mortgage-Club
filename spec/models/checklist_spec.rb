require "rails_helper"

describe Checklist do
  it "has a valid factory" do
    expect(FactoryGirl.build(:checklist, checklist_type: 'explain')).to be_valid
  end

  context "invalid document type" do
    it "raises an error" do
      checklist = FactoryGirl.build(:checklist)
      checklist.document_type = 'fake-document-type'
      checklist.valid?
      expect(checklist.errors[:document_type]).to include("must belong to a proper document")
    end
  end
end
