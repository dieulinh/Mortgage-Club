Feature: BorrowerTabAtNewLoanPage
  @javascript
  Scenario: user submits a new borrower
    When I am at loan management page
      And I should see "Borrower"
      And I click on "Borrower"
      Then I select "As an individual" from "I am applying"
      Then I clear value in "First Name"
        And I fill in "First Name" with "Cuong"
      Then I clear value in "Middle Name"
        And I fill in "Middle Name" with "Manh"
      Then I clear value in "Last Name"
        And I fill in "Last Name" with "Vu"
      And I fill in "Date of Birth" with "03/01/1991"
      Then I clear value in "Social Security Number"
        And I fill in "Social Security Number" with "222222222"
      Then I clear value in "Phone Number"
        And I fill in "Phone Number" with "1234567890"
      Then I clear value in "Years in School"
        And I fill in "Years in School" with "12"
      Then I select "Unmarried" from "Marital Status"
      Then I clear value in "Your Current Address"
        And I fill in "Your Current Address" with "Long Beach, CA, United States"
      Then I choose "true_first_borrower_currently_own"
      Then I click on "Save and Continue"
        And I wait for 2 seconds
        And I should see "W2 - Most recent tax year"
      When I click on "Borrower"
        And I should see "As an individual"
        And the "First Name" field should contain "Cuong"
        And the "Middle Name" field should contain "Manh"
        And the "Last Name" field should contain "Vu"
        And the "Date of Birth" field should contain "03/01/1991"
      When I select "With a co-borrower" from "I am applying"
        And I should see "Please provide information about your co-borrower"
        And I fill in "secondary_borrower_first_name" with "Mark"
        And I fill in "secondary_borrower_last_name" with "John"
        And I fill in "secondary_borrower_dob" with "01/01/1991"
        And I fill in "secondary_borrower_ssn" with "333333333"
        And I fill in "secondary_borrower_phone" with "12222222222"
        And I fill in "secondary_borrower_email" with "co-borrower@gmail.com"
        And I fill in "secondary_borrower_years_in_school" with "9"
        And I fill in "secondary_borrower_current_address" with "Albuquerque, Albuquerque, NM 87106"
        And I choose "true_secondary_borrower_currently_own"
        And I fill in "secondary_borrower_years_in_current_address" with "5"
        And I choose "false_secondary_borrower_self_employed"
        And I select "Married" from "secondary_borrower_marital_status"
        And I fill in "secondary_borrower_dependent_count" with "1"
        And I fill in "secondary_borrower_dependent_ages" with "1"
        Then I click on "Save and Continue"
          And I wait for 2 seconds
        When I click on "Borrower"
          And I should see "With a co-borrower"
          And the "secondary_borrower_first_name" field should contain "Mark"
          And the "secondary_borrower_last_name" field should contain "John"
          And the "secondary_borrower_dob" field should contain "01/01/1991"
          And the "secondary_borrower_email" field should contain "co-borrower@gmail.com"
