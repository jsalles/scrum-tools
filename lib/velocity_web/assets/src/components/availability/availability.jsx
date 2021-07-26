import React from 'react';

const Availability = ({ date, morning, afternoon }) => {
  return (
    <div className="Availability">
      <div>{date}</div>
      <div>
        Morning:
        {morning.availability.map((member) => (
          <div key={member}>{member}</div>
        ))}
      </div>
      <div>
        Afternoon:
        {afternoon.availability.map((member) => (
          <div key={member}>{member}</div>
        ))}
      </div>
    </div>
  );
};

export default Availability;
