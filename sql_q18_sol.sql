WITH fouls AS (SELECT DISTINCT
					COUNT(match_no) OVER(PARTITION BY match_no) AS num_fouls,
                    match_no
				FROM euro_cup_2016.player_booked)

SELECT 
	MAX(num_fouls) AS most_fouls_in_a_game
FROM fouls;