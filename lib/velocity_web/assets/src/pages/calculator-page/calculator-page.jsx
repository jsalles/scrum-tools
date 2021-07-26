import React from 'react';

import SprintList from '../../components/sprint-list/sprint-list';
import { useSprints, useSprintStats } from '../../hooks/sprint-hooks/sprint-hooks';
import { useAverageFocusFactor } from '../../hooks/calendar-hooks/calendar-hooks';
import { useTeamMembers, useTeamKey, useLoadTeams } from '../../hooks/team-hooks/team-hooks';
import { useState } from 'react';

const CalculatorPage = () => {
  const [teamKey] = useTeamKey();
  const [pageSize, setPageSize] = useState(5);
  const [sprints] = useSprints(teamKey, pageSize);
  const [sprintsStats] = useSprintStats(teamKey, sprints);
  const [averageFocusFactor] = useAverageFocusFactor(sprints, sprintsStats);
  const [teams] = useLoadTeams();
  const [members] = useTeamMembers(teams, teamKey);

  return (
    <div className="flex flex-col py-6 items-center bg-gray-200 h-screen overflow-y-scroll">
      <h1 className="text-5xl mb-10">Sprints</h1>
      <div className="mb-5 lg:w-11/12 md:w-full max-w-screen-xl flex justify-end relative">
        <select
          className="block appearance-none border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
          onChange={(e) => {
            setPageSize(e.target.value);
          }}
        >
          <option value="5">5</option>
          <option value="10">10</option>
          <option value="20">20</option>
        </select>
        <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
          <svg
            className="fill-current h-5 w-5"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 20 20"
          >
            <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
          </svg>
        </div>
      </div>
      <SprintList
        sprints={sprints}
        sprintsStats={sprintsStats}
        averageFocusFactor={averageFocusFactor}
        members={members}
      />
    </div>
  );
};

export default CalculatorPage;
