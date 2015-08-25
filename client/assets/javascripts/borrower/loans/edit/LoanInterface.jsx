var _ = require('lodash');
var React = require('react/addons');

var Property = require('./FormProperty');
var Borrower = require('./FormBorrower');
var Income = require('./FormIncome');
var AssetsAndLiabilities = require('./FormAssetsAndLiabilities');
var RealEstates = require('./FormRealEstates');
var Declarations = require('./FormDeclarations');
var ESigning = require('./FormESigning');

var LoanInterface = React.createClass({
  getInitialState: function() {
    var loan = this.props.bootstrapData.currentLoan;
    var borrower_type = this.props.bootstrapData.borrower_type;
    var menu = this.buildMenu(loan);

    return {
      menu: menu,
      active: _.findWhere(menu, {complete: false}) || menu[0],
      loan: loan,
      borrower_type: borrower_type
    };
  },

  render: function() {
    var activeItem = this.state.active;
    var content = <activeItem.Content bootstrapData={this.props.bootstrapData} loan={this.state.loan} borrower_type={this.state.borrower_type} saveLoan={this.save}/>;

    return (
      <div>
        <nav className='sideMenu sticky backgroundLowlight pbm brs'>
          {_.map(this.state.menu, function (item, i) {
            return (
              <div key={i} className={'row pam bbs man ' + (item.name === activeItem.name ? 'backgroundBlue typeReversed' : 'clickable')} onClick={_.bind(this.goToItem, this, item)}>
                <div className='col-xs-9 pan'><i className={item.icon + ' mrxs'}/><span className='h5 typeDeemphasize'>{item.name}</span></div>
                {item.complete ?
                  <div className='col-xs-3 pan text-right typeReversed'><i className='icon iconCheck paxs bas circle xsm backgroundGreen'/></div>
                : null}
              </div>
            );
          }, this)}
        </nav>
        {content}
      </div>
    );
  },

  goToItem: function(item) {
    this.setState({active: item});
  },

  buildMenu: function(loan) {
    var menu = [
      {name: 'Property', complete: loan.property_completed, icon: 'iconHome', Content: Property},
      {name: 'Borrower', complete: loan.borrower_completed, icon: 'iconUser', Content: Borrower},
      {name: 'Income', complete: loan.income_completed, icon: 'iconTicket', Content: Income},
      {name: 'Assets and Liabilities', complete: false, icon: 'iconVcard', Content: AssetsAndLiabilities},
      {name: 'Real Estates', complete: false, icon: 'iconHome', Content: RealEstates},
      {name: 'Declarations', complete: false, icon: 'iconClipboard', Content: Declarations},
      {name: 'ESigning', complete: false, icon: 'iconClipboard', Content: ESigning}
    ];

    return menu;
  },

  save: function(loan, step, skip_change_page) {
    $.ajax({
      url: '/loans/' + this.state.loan.id,
      method: 'PATCH',
      context: this,
      dataType: 'json',
      data: {
        loan: loan,
        current_step: step
      },
      success: function(response) {
        var menu = this.buildMenu(response.loan);
        this.setState({
          loan: response.loan,
          menu: menu
        });

        skip_change_page = (typeof skip_change_page !== 'undefined') ? true : false;
        if (skip_change_page) {
          // TODO: identify what it does when reset active state
          this.setState({
            active: menu[step]
          });
        } else {
          this.setState({
            active: menu[step + 1] || menu[0]
          });
        }
      },
      error: function(response, status, error) {
        alert(error);
      }
    });
  }
});

module.exports = LoanInterface;
