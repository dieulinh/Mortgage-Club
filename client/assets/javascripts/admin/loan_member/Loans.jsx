var _ = require('lodash');
var React = require('react/addons');

var FlashHandler = require('mixins/FlashHandler');

var Loans = React.createClass({
  mixins: [FlashHandler],

  getInitialState: function() {
    return {
    };
  },

  getDefaultProps: function() {
  },

  componentDidMount: function() {
  },

  render: function() {
    return (
      <div className='content container'>
        <h2 className='mbl'>Loans list</h2>
        {
          _.map(this.props.bootstrapData.loans, function(loan) {
            return (
              <p><a href={"/loan_activities/" + loan.id}>Loan of {loan.user.to_s} (email: {loan.user.email})</a></p>
            )
          })
        }
      </div>
    )
  }

});

module.exports = Loans;