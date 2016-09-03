-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

CREATE TABLE players(
  player_id SERIAL PRIMARY KEY,
  player_name TEXT, 
  total_wins INTEGER NOT NULL DEFAULT 0,
  total_losses INTEGER NOT NULL DEFAULT 0,
  total_matches INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE matches(
  match_id SERIAL PRIMARY KEY,
  winner INTEGER references players(player_id), 
  loser INTEGER references players(player_id)
);
CREATE VIEW total_wins as SELECT
                        players.player_name,
                        count(matches.winner) AS winsCount
                        FROM players LEFT JOIN matches
                        ON players.player_id=matches.winner
                        GROUP BY players.player_name ORDER BY winsCount DESC;
CREATE VIEW total_losses as SELECT
                        players.player_name,
                        count(matches.loser) AS lossCount
                        FROM players LEFT JOIN matches
                        ON players.player_id=matches.loser
                        GROUP BY players.player_name ORDER BY lossCount DESC;
CREATE VIEW total_matches as SELECT
                        players.player_name,
                        count(*) AS totalMatchesCount
                        FROM players LEFT JOIN matches
                        ON players.player_id=matches.winner OR players.player_id=matches.loser
                        GROUP BY players.player_name
                        ORDER BY totalMatchesCount DESC;

CREATE VIEW v_standings AS SELECT
                        players.player_id, players.player_name,
                        (SELECT COUNT(*) FROM matches WHERE players.player_id=matches.winner) AS wins,
                        (SELECT COUNT(*) FROM matches WHERE players.player_id=matches.winner OR players.player_id=matches.loser) AS matches
                        FROM players
                        ORDER BY wins DESC;
