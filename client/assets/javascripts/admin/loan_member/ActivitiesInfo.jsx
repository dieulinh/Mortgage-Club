var _ = require('lodash');
var React = require('react/addons');

var ActivitesInfo = React.createClass({
  componentDidMount: function() {
  },

  render: function() {
    return (
      <div>
        {
          _.map(this.props.activitiesList, function(loan_activitiy) {
            return (
              <tr key={loan_activitiy.id}>
                <td>{loan_activitiy.pretty_activity_type}</td>
                <td>{loan_activitiy.name}</td>
                <td>{loan_activitiy.pretty_activity_status}</td>
                <td>{loan_activitiy.pretty_duration}</td>
                <td>{loan_activitiy.pretty_user_visible}</td>
              </tr>
            )
          })
        }
      </div>
    )
  }

});

module.exports = ActivitesInfo;