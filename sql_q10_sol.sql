SELECT
	a.*,
    b.country_name
FROM euro_cup_2016.player_mast AS a
INNER JOIN euro_cup_2016.soccer_country AS b ON a.team_id = b.country_id
WHERE country_name = 'England'
	AND playing_club = 'Liverpool'