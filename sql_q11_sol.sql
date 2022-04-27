SELECT
	a.player_name,
    a.jersey_no,
    a.playing_club
FROM euro_cup_2016.player_mast AS a
INNER JOIN euro_cup_2016.soccer_country AS b ON a.team_id = b.country_id
WHERE b.country_name = 'England'
	AND a.posi_to_play = 'GK'
ORDER BY a.player_name ASC