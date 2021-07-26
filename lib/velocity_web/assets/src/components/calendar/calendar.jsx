import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

import { useNormalizedCalendar } from '../../hooks/calendar-hooks/calendar-hooks';

import WeekDay from '../calendar-day/week-day';
import OutOfSprint from '../calendar-day/out-of-sprint';
import SprintDay from '../calendar-day/sprint-day';

const Calendar = ({ calendar, members }) => {
  const [normalizedCalendar] = useNormalizedCalendar(calendar);

  return (
    <div className="min-w-full flex flex-row flex-wrap justify-between max-w-screen-md px-6">
      {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fry', 'Sat'].map((day) => (
        <WeekDay key={day} day={day} />
      ))}
      {normalizedCalendar.map((day) => {
        const teamSize = members.filter((member) => moment(member.startDate).format('YYYY-MM-DD') <= day.date).length;
        return day.outOfSprint ? (
          <OutOfSprint key={day.date} {...day} />
        ) : (
          <SprintDay key={day.date} {...day} teamSize={teamSize} />
        );
      })}
    </div>
  );
};

Calendar.defaultProps = {
  calendar: null,
  members: [],
};

Calendar.propTypes = {
  calendar: PropTypes.array,
  members: PropTypes.array,
};

export default Calendar;
