export const getSprints = (teamKey) =>
  fetch(`/api/scrum/${teamKey}`, {
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

export const getSprintVelocity = (teamKey, sprint) =>
  fetch(`/api/scrum/${teamKey}/sprints/${sprint.id}/velocity`,{
    method: 'get',
    headers: { Accept: 'application/json' },
  })
  .then((response) => {
    if (!response.ok) {
      throw Error(response.statusText);
    }

    return response.json();
  }).then((body) => body.data);
