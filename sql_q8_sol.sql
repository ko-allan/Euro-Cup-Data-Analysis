SELECT
	a.match_no,
	b.country_name
FROM euro_cup_2016.penalty_shootout AS a
INNER JOIN euro_cup_2016.soccer_country AS b ON a.team_id = b.country_id
ORDER BY kick_no DESC
LIMIT 2;