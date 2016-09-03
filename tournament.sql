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

