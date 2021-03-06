module OcrServices
  #
  # Class ProcessPaystub provides calling ParsePaystubFile, UpdatePaystubOcr, StandardizePaystubData and UpdateEmployment
  # It's a base class of OCR.
  #
  #
  class ProcessPaystub
    def self.call(raw_post)
      data = OcrServices::ParsePaystubFile.call(raw_post)

      return if data.empty?

      borrower_id = data[:borrower_id]
      borrower = Borrower.find_by_id(borrower_id)

      return if borrower.nil?

      OcrServices::UpdatePaystubOcr.new(data, borrower_id).call
      # if paystub_ocr.saved_two_paystub_result? # demo purpose only
      standardized_data = OcrServices::StandardizePaystubData.new(borrower_id).call
      OcrServices::UpdateEmployment.new(standardized_data, borrower_id).call if standardized_data.present?
      # end
    end
  end
end
