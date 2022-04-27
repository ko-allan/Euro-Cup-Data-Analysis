WITH cte AS (SELECT
				match_no,
				goal_score AS team1,
				LEAD(goal_score) OVER(PARTITION BY match_no) AS team2
			FROM euro_cup_2016.match_details
            WHERE decided_by != 'P')
SELECT
	COUNT(match_no) AS match_won_by_1_point_no_penalty
FROM cte
WHERE ABS(team1 - team2 = 1) OR ABS(team2 - team1 = 1)