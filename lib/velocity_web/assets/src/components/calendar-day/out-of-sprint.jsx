import React from 'react';
import moment from 'moment';

const OutOfSprint = ({ date }) => {
  return (
    <div className="calendar-day bg-gray-800">
      <div className="absolute pt-1 pl-1 text-white">{moment(date).format('DD')}</div>
    </div>
  );
};

export default OutOfSprint;
