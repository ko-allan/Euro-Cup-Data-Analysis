SELECT DISTINCT
	players.player_name AS subs_in_first_half_of_normal_play
FROM euro_cup_2016.player_in_out AS subs
INNER JOIN euro_cup_2016.player_mast AS players ON subs.player_id = players.player_id
WHERE in_out = 'I'
	AND play_half = 1
	AND play_schedule = 'NT';