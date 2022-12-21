/*
Football League Information Syatem Database (flisDB) is a relational database schema that manages the information of a
football league for a given season. This FLIS consists of several teams, the teams' players, the
managers who manage the teams, the match information, scores, and the match referees.

Rules followed in ths FLIS:
  ● A player cannot play for more than one team.
  ● Each player is associated with player id, name, date of birth and a jersey number, which is unique for a team.
  ● A manager cannot be associated with more than one team.
  ● Each manager has a manager id, name, date of birth, the year since she/he is managing the team.
  ● A team has a team id, name, city, playground name, and two jersey colors - home jersey color and away jersey color.
  ● Each match is played between two teams - the host team and the guest team.
  ● The match is played on the host team's playground.
  ● There can be only one match per day (date).
  ● Each match is conducted by 4 referees. The role types of the referees are as follows:
      ● Referee (main referee)
      ● Assistant referee-1
      ● Assistant referee-2
      ● Fourth referee
*/
CREATE TABLE managers (
    mgr_id character varying(10) NOT NULL,
    mgr_name character varying(80) NOT NULL,
    dob date NOT NULL,
    team_id character varying(10),
    since date,
    CONSTRAINT managers_pk PRIMARY KEY (mgr_id),
    CONSTRAINT managers_fk3 FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE match_referees (
    match_num character varying(10) NOT NULL,
    referee character varying(15),
    assistant_referee_1 character varying(15),
    assistant_referee_2 character varying(15),
    fourth_referee character varying(15),
    CONSTRAINT match_referees_pkey PRIMARY KEY (match_num),
    CONSTRAINT match_referees_fk0 FOREIGN KEY (match_num) REFERENCES matches(match_num),
    CONSTRAINT match_referees_fk2 FOREIGN KEY (referee) REFERENCES referees(referee_id),
    CONSTRAINT match_referees_fk3 FOREIGN KEY (assistant_referee_1) REFERENCES referees(referee_id),
    CONSTRAINT match_referees_fk4 FOREIGN KEY (assistant_referee_2) REFERENCES referees(referee_id),
    CONSTRAINT match_referees_fk5 FOREIGN KEY (fourth_referee) REFERENCES referees(referee_id)
);

CREATE TABLE matches (
    match_num character varying(10) NOT NULL,
    match_date date NOT NULL,
    host_team_id character varying(10) NOT NULL,
    guest_team_id character varying(10) NOT NULL,
    host_team_score integer NOT NULL,
    guest_team_score integer NOT NULL,
    CONSTRAINT matches_pk PRIMARY KEY (match_num),
    CONSTRAINT matches_fk0 FOREIGN KEY (host_team_id) REFERENCES teams(team_id),
    CONSTRAINT matches_fk1 FOREIGN KEY (guest_team_id) REFERENCES teams(team_id)
);

CREATE TABLE players (
    player_id character varying(10) NOT NULL,
    player_name character varying(80) NOT NULL,
    dob date NOT NULL,
    jersey_no integer NOT NULL,
    team_id character varying(10) NOT NULL,
    CONSTRAINT players_pk PRIMARY KEY (player_id),
    CONSTRAINT players_fk0 FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE referees (
    referee_id character varying(10) NOT NULL,
    referee_name character varying(80) NOT NULL,
    dob date NOT NULL,
    CONSTRAINT referees_pk PRIMARY KEY (referee_id)
);

CREATE TABLE teams (
    team_id character varying(10) NOT NULL,
    teams_name character varying(80) NOT NULL,
    city character varying(80) NOT NULL,
    playground character varying(80) NOT NULL,
    jersey_home_color character varying(80),
    jersey_away_color character varying(80),
    CONSTRAINT teams_pk PRIMARY KEY (team_id)
);
