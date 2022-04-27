SELECT DISTINCT
	a.player_name,
    a.jersey_no
FROM euro_cup_2016.player_mast AS a
INNER JOIN euro_cup_2016.match_details AS b ON a.team_id = b.team_id
WHERE b.play_stage = 'G'
	AND b.player_gk = a.player_id
	AND a.team_id = (SELECT country_id FROM euro_cup_2016.soccer_country WHERE country_name = 'Germany')