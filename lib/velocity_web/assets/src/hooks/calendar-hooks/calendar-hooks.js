import { useState, useEffect, useCallback } from 'react';
import * as Moment from 'moment';
import { extendMoment } from 'moment-range';

import { getCalendar } from '../../services/calendar-service';

const moment = extendMoment(Moment);

export const useLoadCalendar = (teamKey) => {
  const loadCalendar = useCallback(
    async ({ startDate, endDate }) => {
      const result = await getCalendar(
        teamKey,
        moment(startDate).format('YYYY-MM-DD'),
        moment(endDate).format('YYYY-MM-DD'),
      );
      return result;
    },
    [teamKey],
  );

  return loadCalendar;
};

export const useCalculateWorkforce = () => {
  const calculateWorkforce = useCallback(
    (calendar) =>
      calendar.reduce(
        (acc, day) => acc + day.morning.availability.length + day.afternoon.availability.length,
        0,
      ),
    [],
  );

  return calculateWorkforce;
};

export const useNormalizedCalendar = (calendar) => {
  const [normalizedCalendar, setNormalizedCalendar] = useState([]);

  useEffect(() => {
    if (!calendar || !calendar.length) return;

    const firstDay = calendar[0].date;
    const sundayBefore = moment(firstDay).startOf('week');
    const rangeBefore = Array.from(
      moment.range(sundayBefore, firstDay).by('day', { excludeEnd: true }),
    ).map((day) => ({
      date: day.format('YYYY-MM-DD'),
      outOfSprint: true,
    }));
    const lastDay = calendar[calendar.length - 1].afternoon.end_date_time;
    const saturdayAfter = moment(lastDay).endOf('week').add('day', 1).format('YYYY-MM-DD');
    const rangeAfter = Array.from(
      moment.range(lastDay, saturdayAfter).by('day', { excludeEnd: true }),
    ).map((day) => ({
      date: day.format('YYYY-MM-DD'),
      outOfSprint: true,
    }));
    const fullCalendar = [...rangeBefore, ...calendar, ...rangeAfter];
    setNormalizedCalendar(fullCalendar);
  }, [calendar]);

  return [normalizedCalendar];
};

export const useAverageFocusFactor = (sprints, sprintsStats) => {
  const [averageFocusFactor, setAverageFocusFactor] = useState(0);

  useEffect(() => {
    const pastSprintIds = sprints
      .filter((sprint) => sprint.state !== 'future')
      .map((sprint) => sprint.id.toString());
    const { velocitySum, workforceSum} = Object.entries(sprintsStats)
      .filter(([sprintId]) => pastSprintIds.includes(sprintId))
      .map(([sprintId, sprintStats]) => sprintStats)
      .reduce((acc, stats) => ({
        velocitySum: acc.velocitySum + stats.velocity,
        workforceSum: acc.workforceSum + stats.workforce,
    }), { velocitySum: 0, workforceSum: 0 });

    if (workforceSum) {
      setAverageFocusFactor(velocitySum / workforceSum);
    }
  }, [sprints, sprintsStats]);

  return [averageFocusFactor];
};
