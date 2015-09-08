require "rails_helper"

describe Docusign::CreateEnvelopeService do
  let(:user) { FactoryGirl.create(:user) }
  let(:loan) { FactoryGirl.create(:loan_with_all_associations) }
  let(:template) { FactoryGirl.create(:template) }
  # rubocop:disable all
  before(:each) { @envelope_recipients = {"signers"=>[{"tabs"=>{"signHereTabs"=>[{"name"=>"Signature", "tabLabel"=>"Signature 1", "scaleValue"=>1.0, "optional"=>"false", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"78", "yPosition"=>"484", "tabId"=>"d4f005cd-8f63-40b5-a97e-970b735e05e0"}, {"name"=>"Signature", "tabLabel"=>"Signature 3", "scaleValue"=>1.0, "optional"=>"false", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"323", "yPosition"=>"483", "tabId"=>"3499465b-7f55-4f74-995b-0a12d0e19941"}], "dateSignedTabs"=>[{"name"=>"Date Signed", "value"=>"", "tabLabel"=>"Date Signed", "font"=>"lucidaconsole", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"218", "yPosition"=>"518", "tabId"=>"2af1a077-7393-41c4-952f-16392a0860a8"}, {"name"=>"Date Signed", "value"=>"", "tabLabel"=>"Date Signed 3", "font"=>"lucidaconsole", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"468", "yPosition"=>"518", "tabId"=>"5392219d-8c93-4653-aa95-48ee6bdcdb8b"}], "textTabs"=>[{"height"=>55, "isPaymentAmount"=>"false", "validationPattern"=>"", "shared"=>"false", "requireInitialOnSharedChange"=>"false", "requireAll"=>"false", "name"=>"lender_address", "value"=>"", "width"=>162, "required"=>"false", "locked"=>"true", "concealValueOnDocument"=>"false", "disableAutoSize"=>"false", "tabLabel"=>"Text1 2", "font"=>"helvetica", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"107", "yPosition"=>"112", "tabId"=>"6f5fca52-7eab-44fd-937e-13c2ccd7a94a"}, {"height"=>22, "isPaymentAmount"=>"false", "validationPattern"=>"", "shared"=>"false", "requireInitialOnSharedChange"=>"false", "requireAll"=>"false", "name"=>"lender_name", "value"=>"", "width"=>162, "required"=>"false", "locked"=>"true", "concealValueOnDocument"=>"false", "disableAutoSize"=>"false", "tabLabel"=>"Text1", "font"=>"helvetica", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"107", "yPosition"=>"90", "tabId"=>"bf621dce-60f3-4b1b-90ef-f335c7761e34"}, {"height"=>22, "isPaymentAmount"=>"false", "validationPattern"=>"", "shared"=>"false", "requireInitialOnSharedChange"=>"false", "requireAll"=>"false", "name"=>"date", "value"=>"", "width"=>120, "required"=>"false", "locked"=>"true", "concealValueOnDocument"=>"false", "disableAutoSize"=>"false", "tabLabel"=>"Text2", "font"=>"helvetica", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"460", "yPosition"=>"90", "tabId"=>"745ed35a-fed0-462a-af29-7fb4b9b34125"}, {"height"=>22, "isPaymentAmount"=>"false", "validationPattern"=>"", "shared"=>"false", "requireInitialOnSharedChange"=>"false", "requireAll"=>"false", "name"=>"assign_servicing_loan_outstanding", "value"=>"", "width"=>18, "required"=>"false", "locked"=>"true", "concealValueOnDocument"=>"false", "disableAutoSize"=>"false", "tabLabel"=>"Text 1", "font"=>"helvetica", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"69", "yPosition"=>"313", "tabId"=>"bae1f692-2272-499a-8350-9f50535f8fab"}, {"height"=>22, "isPaymentAmount"=>"false", "validationPattern"=>"", "shared"=>"false", "requireInitialOnSharedChange"=>"false", "requireAll"=>"false", "name"=>"assign_servicing_loan_before_first_payment", "value"=>"", "width"=>18, "required"=>"false", "locked"=>"true", "concealValueOnDocument"=>"false", "disableAutoSize"=>"false", "tabLabel"=>"Text 2", "font"=>"helvetica", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"69", "yPosition"=>"349", "tabId"=>"45dfd8a8-881e-4c0d-a3a7-5b47a11900d8"}, {"height"=>22, "isPaymentAmount"=>"false", "validationPattern"=>"", "shared"=>"false", "requireInitialOnSharedChange"=>"false", "requireAll"=>"false", "name"=>"loan_will_be_serviced", "value"=>"", "width"=>18, "required"=>"false", "locked"=>"true", "concealValueOnDocument"=>"false", "disableAutoSize"=>"false", "tabLabel"=>"Text 3", "font"=>"helvetica", "bold"=>"false", "italic"=>"false", "underline"=>"false", "fontColor"=>"black", "fontSize"=>"size9", "documentId"=>"85278153", "recipientId"=>"89556991", "pageNumber"=>"1", "xPosition"=>"69", "yPosition"=>"396", "tabId"=>"9cbdadb7-c05a-44cd-8055-12b8bc025f85"}]}, "isBulkRecipient"=>"false", "recipientSuppliesTabs"=>"false", "name"=>"Billy Tran", "email"=>"billytran1222@gmail.com", "recipientId"=>"89556991", "recipientIdGuid"=>"23945cec-792f-4a91-9fb8-71cfbaaa4640", "requireIdLookup"=>"false", "userId"=>"310acbaa-44dd-4fb5-ae70-475b59dd9b8a", "routingOrder"=>"1", "note"=>"", "status"=>"created", "totalTabCount"=>"10"}], "agents"=>[], "editors"=>[], "intermediaries"=>[], "carbonCopies"=>[], "certifiedDeliveries"=>[], "inPersonSigners"=>[], "recipientCount"=>"1"} }
  # rubocop:enable all
  it "creates an envelope from Docusign successfully" do
    VCR.use_cassette("create an envelope from Docusign") do
      allow_any_instance_of(DocusignRest::Client).to receive(:get_envelope_recipients).and_return(@envelope_recipients)
      envelope_response = Docusign::CreateEnvelopeService.new(user, loan, template).call
      expect(envelope_response).to include(
        "envelopeId",
        "uri",
        "statusDateTime",
        "status"
      )
    end
  end

  it 'saves an envelope to database' do
    VCR.use_cassette("create an envelope from Docusign") do
      allow_any_instance_of(DocusignRest::Client).to receive(:get_envelope_recipients).and_return(@envelope_recipients)
      Docusign::CreateEnvelopeService.new(user, loan, template).call
      expect(Envelope.count).to eq(1)
    end
  end
end
