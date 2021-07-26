import React from 'react';
import PropTypes from 'prop-types';
import { Router, Route, Switch, Redirect } from 'react-router-dom';

import ErrorBoundary from './error-boundary';
import CalculatorPage from '../pages/calculator-page/calculator-page';
import TeamPage from '../pages/team-page/team-page';

const AppRouter = ({ history }) => (
  <ErrorBoundary>
    <Router history={history}>
      <Switch>
        <Route exact path="/" component={TeamPage} />
        <Route path="/:teamKey/sprints" component={CalculatorPage} />
        <Redirect to="/" />
      </Switch>
    </Router>
  </ErrorBoundary>
);

AppRouter.propTypes = {
  history: PropTypes.object.isRequired,
};

export default AppRouter;
