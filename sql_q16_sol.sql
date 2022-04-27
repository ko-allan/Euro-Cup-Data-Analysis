WITH matches AS (SELECT
					match_no,
                    referee_id,
                    venue_id
				FROM euro_cup_2016.match_mast)

SELECT DISTINCT
	referees.referee_name,
	venues.venue_name,
	COUNT(match_no) OVER(PARTITION BY matches.venue_id, matches.referee_id) AS matches_per_venue
FROM matches
INNER JOIN euro_cup_2016.referee_mast AS referees ON matches.referee_id = referees.referee_id
INNER JOIN euro_cup_2016.soccer_venue AS venues ON matches.venue_id = venues.venue_id

ORDER BY referees.referee_name ASC, venues.venue_name ASC, matches_per_venue DESC