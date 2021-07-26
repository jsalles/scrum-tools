import React from 'react';
import moment from 'moment';

import { useLoadTeams, useTeamMembers, useSelectTeamAndGoNext } from '../../hooks/team-hooks/team-hooks';

const TeamPage = () => {
  const [teams] = useLoadTeams();
  const [selectedTeam, setSelectedTeam, goNext] = useSelectTeamAndGoNext();
  const [members] = useTeamMembers(teams, selectedTeam);

  return (
    <div className="flex flex-col py-6 items-center bg-gray-200 h-screen overflow-y-scroll">
      <h1 className="text-5xl mb-10">Teams</h1>
      <div className="flex flex-row">
        <select
          className="block w-64 mr-3 bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 rounded shadow leading-tight focus:outline-none focus:shadow-outline placeholder-gray-500"
          onChange={(e) => setSelectedTeam(e.target.value)}
        >
          <option hidden>Please select...</option>
          {teams.map(({ key, name }) => (<option key={key} value={key}>{name}</option>))}
        </select>
        <button
          className="flex-shrink-0 bg-teal-500 hover:bg-teal-700 border-teal-500 hover:border-teal-700 text-sm border-4 text-white py-1 px-2 rounded"
          type="button"
          onClick={() => goNext()}
        >
          Go!
        </button>
      </div>
      <div className="w-screen max-w-screen-sm mt-4">
        <div className="min-w-full flex pl-2 bg-gray-100 text-sm text-left font-medium text-gray-600 uppercase tracking-wider">
          <div className="w-4/12">Member</div>
          <div className="w-5/12">Email</div>
          <div className="w-3/12">Start Date</div>
        </div>
        {members.map((member) => (
          <div key={member.email} className="min-w-full flex flex-row pl-2 bg-white py-2">
            <div className="w-4/12">{member.name}</div>
            <div className="w-5/12">{member.email}</div>
            <div className="w-3/12">{moment(member.startDate).format('DD.MM.YYYY')}</div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default TeamPage;
