export const getTeams = () =>
  fetch('/api/team', {
    method: 'get',
    headers: { Accept: 'application/json' },
  })
    .then((response) => {
      if (!response.ok) {
        throw Error(response.statusText);
      }

      return response.json();
    })
    .then((body) => body.data);
