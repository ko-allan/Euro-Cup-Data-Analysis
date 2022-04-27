WITH penalties AS (SELECT
						match_no
					FROM euro_cup_2016.player_booked)

SELECT DISTINCT
	referees.referee_name,
    COUNT(penalties.match_no) OVER(PARTITION BY matches.referee_id) AS total_bookings_issued
FROM penalties

INNER JOIN euro_cup_2016.match_mast AS matches ON penalties.match_no = matches.match_no
INNER JOIN euro_cup_2016.referee_mast AS referees ON matches.referee_id = referees.referee_id

ORDER BY total_bookings_issued DESC, referees.referee_name ASC

LIMIT 2;