SELECT DISTINCT
	players.player_name,
    positions.position_desc AS position
FROM euro_cup_2016.player_mast AS players
INNER JOIN euro_cup_2016.goal_details AS goals ON players.player_id = goals.player_id
INNER JOIN euro_cup_2016.playing_position AS positions ON players.posi_to_play = positions.position_id
WHERE positions.position_desc = 'Defenders'
	AND goals.goal_id > 0
ORDER BY players.player_name ASC