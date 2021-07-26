import React from 'react';
import PropTypes from 'prop-types';

import SprintCard from '../sprint-card/sprint-card';

const SprintList = ({ sprints, sprintsStats, averageFocusFactor, members }) => {
  return (
    <div className="lg:w-11/12 md:w-full shadow-lg max-w-screen-xl divide-y divide-gray-200">
      <div className="min-w-full flex bg-gray-100 pl-6 text-left text-xs leading-4 font-medium text-gray-600 uppercase tracking-wider rounded-t-lg">
        <div className="w-6/24 py-3">Name</div>
        <div className="w-4/24 py-3">Start Date</div>
        <div className="w-4/24 py-3">End Date</div>
        <div className="w-3/24 py-3">State</div>
        <div className="w-2/24 py-3">WF</div>
        <div className="w-2/24 py-3">Vel</div>
        <div className="w-2/24 py-3">FF</div>
        <div className="w-1/24" />
      </div>
      {[...sprints].map((sprint) => (
        <SprintCard
          key={sprint.id}
          {...sprint}
          {...(sprintsStats[sprint.id] || {})}
          averageFocusFactor={averageFocusFactor}
          members={members}
        />
      ))}
    </div>
  );
};

SprintList.propTypes = {
  sprints: PropTypes.array.isRequired,
};

export default SprintList;
