import React, { useState } from 'react';
import PropTypes from 'prop-types';
import Expand from 'react-expand-animated';

import Calendar from '../calendar/calendar';
import SprintStats from '../sprint-stats/sprint-stats';

const SprintCard = ({
  name,
  state,
  startDate,
  endDate,
  velocity,
  calendar,
  workforce,
  averageFocusFactor,
  members,
}) => {
  const [isExpanded, setIsExpanded] = useState(false);
  return (
    <div className="bg-white flex flex-col items-center">
      <div
        className="min-w-full py-4 pl-6 cursor-pointer hover:bg-gray-300"
        onClick={() => setIsExpanded(!isExpanded)}
      >
        <SprintStats
          name={name}
          startDate={startDate}
          state={state}
          endDate={endDate}
          workforce={workforce}
          velocity={state === 'future' ? workforce * averageFocusFactor : velocity}
          focusFactor={state === 'future' ? averageFocusFactor : velocity / workforce}
          loading={!calendar}
        />
      </div>
      <Expand open={isExpanded}>
        <div className="px-6 pb-3">
          <Calendar calendar={calendar} members={members} />
        </div>
      </Expand>
    </div>
  );
};

SprintCard.propTypes = {
  name: PropTypes.string.isRequired,
  state: PropTypes.string.isRequired,
  startDate: PropTypes.string,
  endDate: PropTypes.string,
  velocity: PropTypes.number.isRequired,
};

export default SprintCard;
