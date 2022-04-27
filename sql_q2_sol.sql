WITH penalty_wins AS (SELECT decided_by FROM euro_cup_2016.match_mast WHERE decided_by = 'P')

SELECT COUNT(*) AS num_penalty_wins
FROM penalty_wins;