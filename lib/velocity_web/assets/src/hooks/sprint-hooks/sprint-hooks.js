import { useState, useEffect, useReducer } from 'react';
import { useQuery } from 'react-query';
import { getSprints, getSprintVelocity } from '../../services/scrum-service';
import { useLoadCalendar, useCalculateWorkforce } from '../calendar-hooks/calendar-hooks';

export const useSprints = (teamKey, pageSize) => {
  const [sprintsPage, setSprintsPage] = useState([]);

  const { data: sprints } = useQuery(["sprints", teamKey], () => getSprints(teamKey), { placeholderData: [] });

  useEffect(() => {
    if (sprints) {
      const futureSprints = sprints.filter((sprint) => sprint.state === 'future');
      const pastSprints = sprints.filter((sprint) => sprint.state !== 'future').slice(0, pageSize);
      setSprintsPage([...futureSprints, ...pastSprints]);
    }
  }, [sprints, pageSize])

  return [sprintsPage];
};

export const useSprintStats = (teamKey, sprints) => {
  const reducer = (previousStats, action) => {
    const { sprintId, calendar, workforce, velocity } = action;
    return { ...previousStats, [sprintId]: { calendar, workforce, velocity } };
  };
  const [statsForSprints, dispatch] = useReducer(reducer, {});
  const loadCalendar = useLoadCalendar(teamKey);
  const calculateWorkforce = useCalculateWorkforce();

  useEffect(() => {
    const loadSprintStats = () => {
      sprints
        .filter((sprint) => !statsForSprints[sprint.id])
        .map(async (sprint) => {
          const [calendar, velocity] = await Promise.all([loadCalendar(sprint), getSprintVelocity(teamKey, sprint)]);
          const workforce = calculateWorkforce(calendar);
          dispatch({ sprintId: sprint.id, calendar, workforce, velocity });
        });
    };

    if (sprints && sprints.length) {
      loadSprintStats();
    }
  }, [calculateWorkforce, loadCalendar, sprints]);

  return [statsForSprints];
};
