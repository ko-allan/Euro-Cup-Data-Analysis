SELECT
	match_no AS match_number,
    play_date AS date,
    goal_score AS score
FROM euro_cup_2016.match_mast 
WHERE stop1_sec = 0