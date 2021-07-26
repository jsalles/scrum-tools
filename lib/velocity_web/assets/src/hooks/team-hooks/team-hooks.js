import { useState, useEffect, useCallback } from 'react';
import { useHistory, useRouteMatch } from 'react-router-dom';
import { getTeams } from '../../services/team-service';

export const useLoadTeams = () => {
  const [teams, setTeams] = useState([]);

  useEffect(() => {
    const loadTeams = async () => {
      const result = await getTeams();
      setTeams(result);
    };

    loadTeams();
  }, []);

  return [teams];
};

export const useSelectTeamAndGoNext = () => {
  const [selectedTeam, setSelectedTeam] = useState();
  const history = useHistory();

  const goNext = useCallback(() => {
    if (!selectedTeam) {
      alert('Task failed succesfully');
      return;
    }

    history.push(`/${selectedTeam}/sprints`);
  }, [selectedTeam, history]);

  return [selectedTeam, setSelectedTeam, goNext];
};

export const useTeamKey = () => {
  const match = useRouteMatch();
  const { teamKey } = match.params;

  return [teamKey];
};

export const useTeamMembers = (teams, selectedTeam) => {
  const [members, setMembers] = useState([]);

  useEffect(() => {
    if (selectedTeam) {
      const team = teams.find(({ key }) => key === selectedTeam) || {};
      setMembers(team.members);
    }
  }, [teams, selectedTeam]);

  return [members];
};
