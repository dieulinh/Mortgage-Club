var _ = require('lodash');
var React = require('react/addons');
var TextFormatMixin = require('mixins/TextFormatMixin');
var ChecklistUpload = require('../ChecklistUpload');
var ChecklistExplanation = require('../ChecklistExplanation');


var OverviewTab = React.createClass({
  eachChecklist: function(checklist, i) {
    return (
      <CheckList
        key={checklist.id}
        index={i}
        loan={this.props.loan}
        borrower={this.props.borrower}
        checklist={checklist}
        updateChecklistStatus={this.updateChecklistStatus}/>
    );
  },
  updateChecklistStatus: function(checklist) {
    $.ajax({
      url: '/my/checklists/' + checklist.id,
      data: {
        checklist: {
          status: 'done'
        }
      },
      dataType: 'json',
      method: 'PATCH',
      context: this,
      success: function(response) {
        // do something
      }
    });
  },
  render: function() {
    var checklistCounter = this.props.checklists.length;
    var pendingCounter = 0;
    for (var i = 0; i < this.props.checklists.length; i++) {
      if (this.props.checklists[i].status == "pending") {
        pendingCounter += 1;
      }
    }
    var completeCounter = checklistCounter - pendingCounter;

    return (
      <div className="overviewTab">
        <div className="board sign-board">
          <div className="row">
            <div className="col-md-11">
              <h4>We are still waiting on some of your checklist items</h4>
              <p>Go ahead and click 'Get Started' on the items below to start working through your open items</p>
            </div>
            <div className="col-md-1 dashboard-sign">
              <img className="board-side" src="/warning-sign.png"/>
            </div>
          </div>
        </div>
        <div className="box boxBasic backgroundBasic">
          <div className='boxHead bbs'>
            <h4 className='typeBold'>Your Loan Checklist &nbsp;
              <span className="label label-default">{completeCounter + "/" + checklistCounter}</span>
            </h4>

          </div>
          <div className="boxBody ptm">
            <table className="table table-striped">
              <thead>
                <tr>
                  <th>Status</th>
                  <th>Task</th>
                  <th>Info</th>
                  <th>Due</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                {this.props.checklists.map(this.eachChecklist)}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    )
  }
});

module.exports = OverviewTab;


var CheckList = React.createClass({
    mixins: [TextFormatMixin],

    getInitialState: function() {
      return {
        status: this.props.checklist.status == "pending" ? "iconCancel" : "iconCheck",
        logs: []
      }
    },

    componentDidMount: function() {
      $('[data-toggle="popover"]').popover()
    },

    handleShowModal: function() {
      this.refs.modal.show();
    },

    handleExternalHide: function() {
      this.refs.modal.hide();
    },

    uploadSuccessCallback: function() {
      this.setState({
        status: 'iconCheck'
      });
      this.props.updateChecklistStatus(this.props.checklist);
    },

    getSubject: function(checklist) {
      if (checklist.subject_name == 'Borrower') {
        return this.props.loan.borrower;
      } else if (checklist.subject_name == 'Property') {
        return this.props.loan.subject_property;
      } else if (checklist.subject_name == 'Closing') {
        return this.props.loan.closing;
      } else if (checklist.subject_name == 'Loan') {
        return this.props.loan;
      }
    },

    render: function() {
      var checklist = this.props.checklist;
      var button_id = checklist.checklist_type == "explain" ? ("explain-" + checklist.id) : ("upload-" + checklist.id);

      return (
        <tr>
          <td><span className={this.state.status}></span></td>
          <td>{checklist.name}</td>
          <td>
            <button
              className="btnInfo"
              data-toggle="popover"
              data-trigger="focus"
              title="Enter the required entity information"
              data-content={checklist.info}>
              <span className="iconInfo"></span>
            </button>
          </td>
          <td>{this.isoToUsDate(checklist.due_date)}</td>
          <td>
            { checklist.checklist_type == "explain" ?
                <div>
                  <button className="btn btnSml btnDefault" onClick={this.handleShowModal} >
                    {checklist.status == "done" ? "Review" : "Explain"}
                  </button>
                  <ChecklistExplanation
                    ref="modal"
                    show={false}
                    id={button_id}
                    title={checklist.name}
                    loan={this.props.loan}
                    checklist={checklist}/>
                </div>
                :
                <div>
                  <button className="btn btnSml btnDefault" data-toggle="modal" data-target={"#" + button_id}>
                    {checklist.status == "done" ? "Review" : "Upload"}
                  </button>
                  <ChecklistUpload
                    id={button_id}
                    title="Upload"
                    loan={this.props.loan}
                    borrower={this.props.borrower}
                    checklist={checklist}
                    subject={this.getSubject(checklist)}
                    uploadSuccessCallback={this.uploadSuccessCallback}/>
                </div>
            }
          </td>
        </tr>
      );
    }
});
