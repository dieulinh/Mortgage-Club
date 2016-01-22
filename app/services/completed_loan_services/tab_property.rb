module CompletedLoanServices
  class TabProperty
    attr_accessor :loan, :subject_property

    def initialize(loan, subject_property)
      @loan = loan
      @subject_property = subject_property
    end

    def call
      return false unless loan.properties.size > 0
      return false unless subject_property
      return false unless subject_property_completed?
      return false unless purpose_completed?

      true
    end

    def subject_property_completed?
      # return false unless subject_property.property_type.present?
      return false unless subject_property.address.present?
      return false unless address_completed?
      return false unless subject_property.usage.present?
      # return false unless subject_property.market_price.present?
      # return false unless subject_property.mortgage_includes_escrows.present?
      # return false unless subject_property.estimated_property_tax.present?
      # return false unless subject_property.estimated_hazard_insurance.present?

      true
    end

    def purpose_completed?
      return false unless loan.purpose.present?
      return false if loan.purchase? && !subject_property.purchase_price.present?
      return false if loan.refinance? && !refinance_completed?

      true
    end

    def refinance_completed?
      return false unless subject_property.original_purchase_price.present?
      return false unless subject_property.original_purchase_year.present?

      true
    end

    def address_completed?
      return false unless subject_property.address

      address = subject_property.address
      return false if address.street_address.blank? && address.city.blank? && address.state.blank? && address.street_address2.blank?

      address.full_text.present?
    end
  end
end