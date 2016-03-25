Feature: AddDocuments
  @javascript
  Scenario: add documents
    When I am at loan management page
      And I should see "Documents"
      And I click "Documents" in the "#tabDocuments"
      And I should see "W2 - Most recent tax year"
        Then I drag the file "spec/files/sample.pdf" to "first_w2"
        And I should see "sample.pdf" within "#first_w2_id"
      And I should see "W2 - Previous tax year"
        Then I drag the file "spec/files/sample.pdf" to "second_w2"
        And I should see "sample.pdf" within "#second_w2_id"
      And I should see "Paystub - Most recent period"
        Then I drag the file "spec/files/sample.pdf" to "first_paystub"
        And I should see "sample.pdf" within "#first_paystub_id"
      And I should see "Paystub - Previous period"
        Then I drag the file "spec/files/sample.pdf" to "second_paystub"
        And I should see "sample.pdf" within "#second_paystub_id"
      And I should see "Federal tax return - Most recent year"
        Then I drag the file "spec/files/sample.pdf" to "first_federal_tax_return"
        And I should see "sample.pdf" within "#first_federal_tax_return_id"
      And I should see "Federal tax return - Previous year"
        Then I drag the file "spec/files/sample.pdf" to "second_federal_tax_return"
        And I should see "sample.pdf" within "#second_federal_tax_return_id"
      And I should see "Bank statement - Most recent month"
        Then I drag the file "spec/files/sample.pdf" to "first_bank_statement"
        And I should see "sample.pdf" within "#first_bank_statement_id"
      And I should see "Bank statement - Previous month"
        Then I drag the file "spec/files/sample.pdf" to "second_bank_statement"
        And I should see "sample.pdf" within "#second_bank_statement_id"
      And I click "Borrower" in the "#tabBorrower"
        And I choose "true_first_borrower_self_employed"
        Then I click on "Save and Continue"
          And I should see "Personal tax return - Most recent year"
            Then I drag the file "spec/files/sample.pdf" to "first_personal_tax_return"
            And I should see "sample.pdf" within "#first_personal_tax_return_id"
          And I should see "Personal tax return - Previous year"
            Then I drag the file "spec/files/sample.pdf" to "second_personal_tax_return"
            And I should see "sample.pdf" within "#second_personal_tax_return_id"
          And I should see "Business tax return - Most recent year"
            Then I drag the file "spec/files/sample.pdf" to "first_business_tax_return"
            And I should see "sample.pdf" within "#first_business_tax_return_id"
          And I should see "Business tax return - Previous year"
            Then I drag the file "spec/files/sample.pdf" to "second_business_tax_return"
            And I should see "sample.pdf" within "#second_business_tax_return_id"
          And I should see "Bank statement - Most recent month"
            Then I drag the file "spec/files/sample.pdf" to "first_bank_statement"
            And I should see "sample.pdf" within "#first_bank_statement_id"
          And I should see "Bank statement - Previous month"
            Then I drag the file "spec/files/sample.pdf" to "second_bank_statement"
            And I should see "sample.pdf" within "#second_bank_statement_id"
      When I click "Borrower" in the "#tabBorrower"
      When I select "With a co-borrower" from "I am applying"
        And I should see "Please provide information about your co-borrower"
        And I fill in "secondary_borrower_first_name" with "Mark"
        And I fill in "secondary_borrower_last_name" with "John"
        And I fill in "secondary_borrower_dob" with "01/01/1991"
        And I fill in "secondary_borrower_ssn" with "1234567891"
        And I fill in "secondary_borrower_phone" with "1234567891"
        And I fill in "secondary_borrower_email" with "co-borrower@gmail.com"
        And I fill in "secondary_borrower_years_in_school" with "9"
        And I fill in "secondary_borrower_current_address" with "1920 South Las Vegas Boulevard"
        And I wait for 2 seconds
        And I choose "true_secondary_borrower_currently_own"
        And I choose "true_secondary_borrower_currently_own"
        And I fill in "secondary_borrower_years_in_current_address" with "5"
        And I choose "false_secondary_borrower_self_employed"
        And I choose "true_secondary_borrower_currently_own"
        And I select "Married" from "secondary_borrower_marital_status"
        And I fill in "secondary_borrower_dependent_count" with "1"
        And I fill in "secondary_borrower_dependent_ages" with "1"
        Then I click on "Save and Continue"
        And I wait for 2 seconds
      When I click "Documents" in the "#tabDocuments"
        And I should see "Do you and your co-borrower file taxes jointly?"
        When I choose "false_is_file_taxes_jointly"
          And I should see "Please upload the following documents for your co-borrower."
          And I should see "W2 - Most recent tax year"
            Then I drag the file "spec/files/sample.pdf" to "co_first_w2"
            And I should see "sample.pdf" within "#co_first_w2_id"
          And I should see "W2 - Previous tax year"
            Then I drag the file "spec/files/sample.pdf" to "co_second_w2"
            And I should see "sample.pdf" within "#co_second_w2_id"
          And I should see "Paystub - Most recent period"
            Then I drag the file "spec/files/sample.pdf" to "co_first_paystub"
            And I should see "sample.pdf" within "#co_first_paystub_id"
          And I should see "Paystub - Previous period"
            Then I drag the file "spec/files/sample.pdf" to "co_second_paystub"
            And I should see "sample.pdf" within "#co_second_paystub_id"
          And I should see "Federal tax return - Most recent year"
            Then I drag the file "spec/files/sample.pdf" to "co_first_federal_tax_return"
            And I should see "sample.pdf" within "#co_first_federal_tax_return_id"
          And I should see "Federal tax return - Previous year"
            Then I drag the file "spec/files/sample.pdf" to "co_second_federal_tax_return"
            And I should see "sample.pdf" within "#co_second_federal_tax_return_id"
          And I should see "Bank statement - Most recent month"
            Then I drag the file "spec/files/sample.pdf" to "co_first_bank_statement"
            And I should see "sample.pdf" within "#co_first_bank_statement_id"
          And I should see "Bank statement - Previous month"
            Then I drag the file "spec/files/sample.pdf" to "co_second_bank_statement"
            And I should see "sample.pdf" within "#co_second_bank_statement_id"
        When I choose "true_is_file_taxes_jointly"
          And I should see "W2 - Most recent tax year"
          And I should see "W2 - Previous tax year"
          And I should see "Paystub - Most recent period"
          And I should see "Paystub - Previous period"
          And I should see "Bank statement - Most recent month"
          And I should see "Bank statement - Previous month"
      When I click "Borrower" in the "#tabBorrower"
        And I choose "true_secondary_borrower_self_employed"
          Then I click on "Save and Continue"
        When I choose "false_is_file_taxes_jointly"
          And I should see "Personal tax return - Most recent year"
            Then I drag the file "spec/files/sample.pdf" to "co_first_personal_tax_return"
            And I should see "sample.pdf" within "#co_first_personal_tax_return_id"
          And I should see "Personal tax return - Previous year"
            Then I drag the file "spec/files/sample.pdf" to "co_second_personal_tax_return"
            And I should see "sample.pdf" within "#co_second_personal_tax_return_id"
          And I should see "Business tax return - Most recent year"
            Then I drag the file "spec/files/sample.pdf" to "co_first_business_tax_return"
            And I should see "sample.pdf" within "#co_first_business_tax_return_id"
          And I should see "Business tax return - Previous year"
            Then I drag the file "spec/files/sample.pdf" to "co_second_business_tax_return"
            And I should see "sample.pdf" within "#co_second_business_tax_return_id"
          And I should see "Bank statement - Most recent month"
            Then I drag the file "spec/files/sample.pdf" to "co_first_bank_statement"
            And I should see "sample.pdf" within "#co_first_bank_statement_id"
          And I should see "Bank statement - Previous month"
            Then I drag the file "spec/files/sample.pdf" to "co_second_bank_statement"
            And I should see "sample.pdf" within "#co_second_bank_statement_id"
        When I choose "true_is_file_taxes_jointly"
          And I should see "Business tax return - Most recent year"
          And I should see "Business tax return - Previous year"
          And I should see "Bank statement - Most recent month"
          And I should see "Bank statement - Previous month"
        Then I click on "Next"
          And I should see "Name Of Current Employer"