import React from 'react';
import moment from 'moment';
import classnames from 'classnames';
import ReactTooltip from 'react-tooltip';

import Availability from '../availability/availability';

const SprintDay = ({ date, morning, afternoon, teamSize }) => {
  return (
    <div className="calendar-day">
      <div
        className={classnames('absolute', {
          'jst-triangle-left-gray-500': !morning.workable,
          'jst-triangle-left-green-500':
            morning.workable && morning.availability.length === teamSize,
          'jst-triangle-left-yellow-400':
            morning.workable &&
            morning.availability.length > 0 &&
            morning.availability.length < teamSize,
          'jst-triangle-left-red-500': morning.workable && morning.availability.length === 0,
        })}
      />
      <div
        className={classnames('absolute', {
          'jst-triangle-right-gray-500': !afternoon.workable,
          'jst-triangle-right-green-500':
            afternoon.workable && afternoon.availability.length === teamSize,
          'jst-triangle-right-yellow-400':
            afternoon.workable &&
            afternoon.availability.length > 0 &&
            afternoon.availability.length < teamSize,
          'jst-triangle-right-red-500': afternoon.workable && afternoon.availability.length === 0,
        })}
      />
      <div className="absolute pt-1 pl-1 text-black">
        <span data-tip data-for={`toolTip-${date}`}>
          {moment(date).format('DD')}
        </span>
        <ReactTooltip type="light" effect="solid" id={`toolTip-${date}`}>
          <Availability date={date} morning={morning} afternoon={afternoon} />
        </ReactTooltip>
      </div>
    </div>
  );
};

export default SprintDay;
