WITH substitutions AS (SELECT in_out FROM euro_cup_2016.player_in_out WHERE in_out = 'O')

SELECT COUNT(*) AS total_tourney_substitutions
FROM substitutions