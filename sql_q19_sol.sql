SELECT
	COUNT(player_id) AS goalkeeper_captains
FROM euro_cup_2016.player_mast AS players
INNER JOIN euro_cup_2016.match_captain AS captains ON players.player_id = captains.player_captain
WHERE posi_to_play = 'GK';