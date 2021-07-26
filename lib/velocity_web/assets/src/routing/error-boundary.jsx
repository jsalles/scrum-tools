import React from 'react';
import PropTypes from 'prop-types';

import './error-boundary.scss';

class ErrorBoundary extends React.Component {
  static propTypes = {
    children: PropTypes.any.isRequired,
  };

  state = {
    hasError: false,
  };

  componentDidCatch(error, info) {
    this.setState({ hasError: true });
    console.error('React rendering error', { error, info });
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="ErrorBoundary">
          <h1 className="ErrorBoundary-headline">500 - Seitenaufruf ist fehlgeschlagen</h1>
          <p className="ErrorBoundary-paragraph">
            Die Webadresse, die Sie aufgerufen haben, ist fehlerhaft. Bitte verwenden Sie eine
            korrekte Webadresse.
          </p>
        </div>
      );
    }
    return this.props.children;
  }
}

export default ErrorBoundary;
