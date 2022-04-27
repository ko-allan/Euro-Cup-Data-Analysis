WITH goals AS (SELECT goal_id, player_id, team_id FROM euro_cup_2016.goal_details)

SELECT DISTINCT
    countries.country_name,
    players.posi_to_play AS position,
    COUNT(goals.goal_id) OVER(PARTITION BY goals.team_id, players.posi_to_play) AS total_goals_per_position
FROM goals
INNER JOIN euro_cup_2016.player_mast AS players ON goals.player_id = players.player_id
INNER JOIN euro_cup_2016.soccer_country AS countries ON goals.team_id = countries.country_id
ORDER BY countries.country_name ASC, position ASC
