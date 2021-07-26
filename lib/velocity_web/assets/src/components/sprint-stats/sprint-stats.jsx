import React from 'react';
import moment from 'moment';
import Spinner from '../spinner/spinner';

const SprintStats = ({
  name,
  startDate,
  endDate,
  state,
  workforce,
  velocity,
  focusFactor,
  loading,
}) => {
  return (
    <div className="w-full flex flex-row justify-between">
      <div className="w-6/24 text-lg text-gray-700">{name}</div>
      <div className="w-4/24 text-lg text-gray-700">{moment(startDate).format('DD.MM.YYYY')}</div>
      <div className="w-4/24 text-lg text-gray-700">{moment(endDate).format('DD.MM.YYYY')}</div>
      <div className="w-3/24 text-lg text-gray-700">{state}</div>
      <div className="w-2/24 text-lg text-gray-700">{workforce}</div>
      <div className="w-2/24 text-lg text-gray-700">{velocity ? velocity.toFixed(0) : ''}</div>
      <div className="w-2/24 text-lg text-gray-700">
        {focusFactor ? focusFactor.toFixed(2) : ''}
      </div>
      <div className="w-1/24 pt-1">{loading && <Spinner />}</div>
    </div>
  );
};

export default SprintStats;
