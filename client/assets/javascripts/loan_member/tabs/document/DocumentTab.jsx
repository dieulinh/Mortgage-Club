var _ = require('lodash');
var React = require('react/addons');
var Upload = require('./Upload');

var descriptionDrap = "Drop files to upload or CLICK";
var borrower_fields = {
  first_w2: {label: 'W2 - Most recent tax year', name: 'first_w2', placeholder: descriptionDrap, type: 'FirstW2'},
  second_w2: {label: 'W2 - Previous tax year', name: 'second_w2', placeholder: descriptionDrap, type: 'SecondW2'},
  first_paystub: {label: "Paystub - Most recent period", name: 'first_paystub', placeholder: descriptionDrap, type: 'FirstPaystub'},
  second_paystub: {label: 'Paystub - Previous period', name: 'second_paystub', placeholder: descriptionDrap, type: 'SecondPaystub'},
  first_bank_statement: {label: 'Bank statement - Most recent month', name: 'first_bank_statement', placeholder: descriptionDrap, type: 'FirstBankStatement'},
  second_bank_statement: {label: 'Bank statement - Previous month', name: 'second_bank_statement', placeholder: descriptionDrap, type: 'SecondBankStatement'},
  first_personal_tax_return: {label: 'Personal tax return - Most recent year', name: 'first_personal_tax_return', placeholder: descriptionDrap, type: 'FirstPersonalTaxReturn'},
  second_personal_tax_return: {label: 'Personal tax return - Previous year', name: 'second_personal_tax_return', placeholder: descriptionDrap, type: 'SecondPersonalTaxReturn'},
  first_business_tax_return: {label: 'Business tax return - Most recent year', name: 'first_business_tax_return', placeholder: descriptionDrap, type: 'FirstBusinessTaxReturn'},
  second_business_tax_return: {label: 'Business tax return - Previous year', name: 'second_business_tax_return', placeholder: descriptionDrap, type: 'SecondBusinessTaxReturn'}
};
var loan_fields = {
  hud_estimate: {label: 'Estimated settlement statement', name: 'hud_estimate', placeholder: descriptionDrap, type: 'HudEstimate'},
  hud_final: {label: 'Final settlement statement', name: 'hud_final', placeholder: descriptionDrap, type: 'HudFinal'},
  loan_estimate: {label: "Loan estimate", name: 'loan_estimate', placeholder: descriptionDrap, type: 'LoanEstimate'},
  uniform_residential_lending_application: {label: 'Loan application form', name: 'uniform_residential_lending_application', placeholder: descriptionDrap, type: 'UniformResidentialLendingApplication'}
}
var closing_fields = {
  closing_disclosure: {label: 'Closing Disclosure', name: 'closing_disclosure', placeholder: descriptionDrap, type: 'ClosingDisclosure'},
  deed_of_trust: {label: 'Deed of Trust', name: 'deed_of_trust', placeholder: descriptionDrap, type: 'DeedOfTrust'},
  loan_doc: {label: "Loan Document", name: 'loan_doc', placeholder: descriptionDrap, type: 'LoanDoc'}
}
var property_fields = {
  appraisal_report: {label: 'Appraised property value', name: 'appraisal_report', placeholder: descriptionDrap, type: 'AppraisalReport'},
  flood_zone_certification: {label: 'Flood zone certification', name: 'flood_zone_certification', placeholder: descriptionDrap, type: 'FloodZoneCertification'},
  homeowners_insurance: {label: "Homeowner's insurance", name: 'homeowners_insurance', placeholder: descriptionDrap, type: 'HomeownersInsurance'},
  inspection_report: {label: 'Home inspection report', name: 'inspection_report', placeholder: descriptionDrap, type: 'InspectionReport'},
  lease_agreement: {label: 'Lease agreement', name: 'lease_agreement', placeholder: descriptionDrap, type: 'LeaseAgreement'},
  mortgage_statement: {label: 'Latest mortgage statement of subject property', name: 'mortgage_statement', placeholder: descriptionDrap, type: 'MortgageStatement'},
  purchase_agreement: {label: 'Executed purchase agreement', name: 'purchase_agreement', placeholder: descriptionDrap, type: 'PurchaseAgreement'},
  risk_report: {label: "Home seller's disclosure report", name: 'risk_report', placeholder: descriptionDrap, type: 'RiskReport'},
  termite_report: {label: 'Termite report', name: 'termite_report', placeholder: descriptionDrap, type: 'TermiteReport'},
  title_report: {label: 'Preliminary title report', name: 'title_report', placeholder: descriptionDrap, type: 'TitleReport'}
}

var DocumentTab = React.createClass({
  getInitialState: function() {
    return {
      displayProperty: {display: true},
      displayBorrower: {display: 'none'},
      displayLoan: {display: 'none'},
      displayClosing: {display: 'none'}
    };
  },

  componentDidMount: function () {
    $('.bootstrap-select').selectpicker();
    $('.bootstrap-select').change(this.onChange);
  },

  onChange: function(event) {
    var type_of_document = event.target.value;
    switch(type_of_document) {
      case "property":
        this.setState({displayProperty: {display: true},
          displayBorrower: {display: 'none'},
          displayLoan: {display: 'none'},
          displayClosing: {display: 'none'}
        });
        break;
      case "borrower":
        this.setState({displayBorrower: {display: true},
          displayProperty: {display: 'none'},
          displayLoan: {display: 'none'},
          displayClosing: {display: 'none'}
        });
        break;
      case "loan":
        this.setState({displayLoan: {display: true},
          displayProperty: {display: 'none'},
          displayBorrower: {display: 'none'},
          displayClosing: {display: 'none'}
        });
        break;
      case "closing":
        this.setState({displayClosing: {display: true},
          displayLoan: {display: 'none'},
          displayProperty: {display: 'none'},
          displayBorrower: {display: 'none'}
        });
        break;
    }
  },

  render: function() {
    return (
      <div className="panel panel-flat">
        <div className="panel-heading">
          <h4 className="panel-title">Documents</h4>
        </div>
        <div className="panel-body" style={{"margin-top":"20px"}}>
          <div className="row" style={{"margin-bottom":"10px"}}>
            <div className="col-xs-4">
              <select className="form-control bootstrap-select show-tick" onChange={this.onChange}>
                <option value="property">Property Document</option>
                <option value="borrower">Borrower Document</option>
                <option value="loan">Loan Document</option>
                <option value="closing">Closing Document</option>
              </select>
            </div>
          </div>
          <div id="property_uploader" className="row" style={this.state.displayProperty}>
            <Upload subjectType={"Property"} subject={this.props.property} fields={property_fields}></Upload>
          </div>
          <div id="borrower_document_uploader" className="row" style={this.state.displayBorrower}>
            <Upload subjectType={"Borrower"} subject={this.props.borrower} fields={borrower_fields}></Upload>
          </div>
          <div id="loan_uploader" className="row" style={this.state.displayLoan}>
            <Upload subjectType={"Loan"} subject={this.props.loan} fields={loan_fields}></Upload>
          </div>
          <div id="closing_uploader" className="row" style={this.state.displayClosing}>
            <Upload subjectType={"Closing"} subject={this.props.closing} fields={closing_fields}></Upload>
          </div>
        </div>
      </div>
    );
  }
});

module.exports = DocumentTab;
