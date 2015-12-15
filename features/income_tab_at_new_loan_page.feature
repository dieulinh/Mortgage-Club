Feature: IncomeTabAtNewLoanPage
  @javascript
  Scenario: User updates his income detail
    When I am at loan management page
      And I should see "Income"
      And I click "Income" in the "#tabIncome"
      Then I fill in "Name of current employer" with "Any Company"
        Then I clear value in "Job Title"
          And I fill in "Job Title" with "Software Engineer"
        Then I clear value in "Years at this employer"
          And I fill in "Years at this employer" with "12"
      Then I clear value in "Contact Name"
        And I fill in "Contact Name" with "Cuong Vu"
      Then I clear value in "Contact Phone Number"
        And I fill in "Contact Phone Number" with "0912345678"
      Then I clear value in "Base Income"
        And I fill in "Base Income" with "123454"
      Then I click link with div ".overtime .iconTrash"
        And I click link with div ".commission .iconTrash"
        And I click link with div ".bonus .iconTrash"
      Then I click on "Add other income"
        And I should see "Income Type"
        And I should see "Annual Gross Amount"
        And I select "Interest" from "Income Type"
        And I clear value in "Annual Gross Amount"
        And I fill in "Annual Gross Amount" with "9876"
      Then I click on "Save and Continue"
        And I wait for 2 seconds
      And I click "Income" in the "#tabIncome"
        Then I should see content as "Software Engineer"
          And I should see content as "Cuong Vu"
          And I should see content as "0912345678"
          And I should see content as "$123,454"
      And I should see "Documents"
      # And I click "Documents" in the "#tabDocuments"
      # And I wait for 2 seconds
      # Then I drag the file "spec/files/sample.pdf" to "first_personal_tax_return"
      #   And I wait for 2 seconds
      #   And I should see "sample.pdf"