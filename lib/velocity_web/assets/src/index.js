import React from 'react';
import ReactDOM from 'react-dom';
import './styles.css';
import { createBrowserHistory } from 'history';
import { QueryClient, QueryClientProvider, useQuery } from 'react-query';
import { ReactQueryDevtools } from 'react-query/devtools';

import AppRouter from './routing/app-router';

const queryClient = new QueryClient({ defaultOptions: { queries: { staleTime: Infinity }}});

const history = createBrowserHistory();

ReactDOM.render(
  <QueryClientProvider client={queryClient}>
    <AppRouter history={history} />
    <ReactQueryDevtools />
  </QueryClientProvider>,
  document.getElementById('root'),
);
