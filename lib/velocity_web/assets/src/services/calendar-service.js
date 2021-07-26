export const getCalendar = (teamKey, startDate, endDate) =>
  fetch(`/api/calendar/${teamKey}/${startDate}/${endDate}`, {
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
