var React = require('react/addons');
var Router = require('react-router');
var DefaultRoute = Router.DefaultRoute;
var Route = Router.Route;
var RouteHandler = Router.RouteHandler;

var AppStarter = require('./tools/AppStarter');
var $ = require('jquery');

var LoanActivity = require('./admin/loan_member/LoanActivity');

window.AdminApp = React.createClass({
  contextTypes: {
    router: React.PropTypes.func
  },

  render: function() {
    var user = this.props.currentUser;

    return (
      <div>
        <nav className='topMenu sticky backgroundInverse pvm zIndexNavigation overlayFullWidth'>
          <div className='plm prl'>
            <div className='row'>
              <div className='col-xs-6 typeLowlight'>
                MortgageClub Logo
              </div>
              <div className='col-xs-6 text-right'>
                {user
                ? <span>
                    <a className='mrm' href='/dashboard'>Dashboard</a>
                    <span className='typeLowlight mrm'>Hello <a className='linkTypeReversed' href='/auth/register/edit' data-method='get'>{user.firstName}</a>!</span>
                    <a className='linkTypeReversed' href='/auth/logout' data-method='delete'>Log out</a>
                  </span>
                : <span>
                    <a className='linkTypeReversed mrm' href='/auth/login'>
                      Log in
                    </a>
                    <a className='linkTypeReversed mrm' href='/auth/register/signup'>
                      Sign up
                    </a>
                  </span>
                }
              </div>
            </div>
          </div>
        </nav>

        <div className='page-alert'/>

        <RouteHandler bootstrapData={this.props}/>
      </div>
    );
  }
});

var routes = (
  <Route name='app' path='/' handler={AdminApp}>
    <Route name='loan_activity' path='/loan_activities' handler={LoanActivity}/>
    <DefaultRoute handler={LoanActivity}/>
  </Route>
);

$(function() {
  AppStarter.start(routes);
});
