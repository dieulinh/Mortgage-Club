Feature: RemoveDocusignTemplate
  @javascript
  Scenario: remove a docusign template
    Given there is a admin with the first name "Admin" and with the email "admin@man.net" and the password "secretpass" and the password confirmation "secretpass"
    Given there is a template with the name "Loan Estimate" and with the state "California" and the description "sample description" and the email subject "Hello" and the email body "Sample body" and the docusign id "docusign id" and the document order "1"
      And there is a loans members association
      And I login as "admin@man.net" with password "secretpass"
    Then I should see "Admin"
      And I click "Admin"
      And I should see "Docusign Templates"
     Then I click "Docusign Templates"
      And I should see "Docusign Template - Management"
      And I should see "Edit"
      And I click on "Edit" in the ".linkTypeReversed"
    Then I click on "Remove" in the ".btn-danger"
      And I press "Yes" in the modal "removeDocusignTemplate"
    Then I should be on the docusign template managements page