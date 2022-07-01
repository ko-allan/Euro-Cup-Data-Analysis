# Euro-Cup-Data-Analysis
This repository takes a look at SQL queries on EuroCup's 2016 data

# Questions

## 1. Write a SQL query to find the date EURO Cup 2016 started on.
      SELECT play_date

      FROM euro_cup_2016.match_mast

      ORDER BY play_date ASC

      LIMIT 1;

## 2. Write a SQL query to find the number of matches that were won by penalty shootout.
      WITH penalty_wins AS (SELECT decided_by 
                            FROM euro_cup_2016.match_mast
                            WHERE decided_by = 'P')
      
      SELECT COUNT(*) AS num_penalty_wins

      FROM penalty_wins;

## 3. Write a SQL query to find the match number, date, and score for matches in which no stoppage time was added in the 1st half.
      SELECT match_no AS match_number, 
             play_date AS date, 
             goal_score AS score
      
      FROM euro_cup_2016.match_mast 
      
      WHERE stop1_sec = 0;
      
## 4. Write a SQL query to compute a list showing the number of substitutions that happened in various stages of play for the entire tournament.
      WITH substitutions AS (SELECT in_out 
                             FROM euro_cup_2016.player_in_out
                             WHERE in_out = 'O')
      
      SELECT COUNT(*) AS total_tourney_substitutions
      
      FROM substitutions;
      
## 5. Write a SQL query to find the number of bookings that happened in stoppage time.
      SELECT COUNT(play_schedule) AS bookings_in_stoppage_time
      
      FROM euro_cup_2016.player_booked
      
      WHERE play_schedule = 'ST';
      
## 6. Write a SQL query to find the number of matches that were won by a single point, but do not include matches decided by penalty shootout.
      WITH cte AS (SELECT match_no,
                          goal_score AS team1,
                   LEAD(goal_score) OVER(PARTITION BY match_no) AS team2
                   FROM euro_cup_2016.match_details
                   WHERE decided_by != 'P')
                   
      SELECT COUNT(match_no) AS match_won_by_1_point_no_penalty
      
      FROM cte
      
      WHERE ABS(team1 - team2 = 1) OR ABS(team2 - team1 = 1);
      
## 7. Write a SQL query to find all the venues where matches with penalty shootouts were played.
      SELECT venue.venue_name
      
      FROM euro_cup_2016.match_mast AS mtch

      INNER JOIN euro_cup_2016.soccer_venue AS venue ON mtch.venue_id = venue.venue_id

      WHERE mtch.decided_by = 'P'
      
## 8. Write a SQL query to find the match number for the game with the highest number of penalty shots, and which countries played that match.
      SELECT a.match_no,
             b.country_name
          
      FROM euro_cup_2016.penalty_shootout AS a
      
      INNER JOIN euro_cup_2016.soccer_country AS b ON a.team_id = b.country_id
      
      ORDER BY kick_no DESC
      
      LIMIT 2;
      
## 9. Write a SQL query to find the goalkeeper’s name and jersey number, playing for Germany, who played in Germany’s group stage matches.
      SELECT DISTINCT a.player_name,
                      a.jersey_no
                      
      FROM euro_cup_2016.player_mast AS a
      
      INNER JOIN euro_cup_2016.match_details AS b ON a.team_id = b.team_id
      
      WHERE b.play_stage = 'G'
        AND b.player_gk = a.player_id
        AND a.team_id = (SELECT country_id FROM euro_cup_2016.soccer_country WHERE country_name = 'Germany');
        
## 10. Write a SQL query to find all available information about the players under contract to Liverpool F.C. playing for England in EURO Cup 2016.
      SELECT a.*,
             b.country_name
             
      FROM euro_cup_2016.player_mast AS a
      
      INNER JOIN euro_cup_2016.soccer_country AS b ON a.team_id = b.country_id
      
      WHERE country_name = 'England'
        AND playing_club = 'Liverpool';

## 11. Write a SQL query to find the players, their jersey number, and playing club who were the goalkeepers for England in EURO Cup 2016.
      SELECT a.player_name,
             a.jersey_no,
             a.playing_club
             
      FROM euro_cup_2016.player_mast AS a
      
      INNER JOIN euro_cup_2016.soccer_country AS b ON a.team_id = b.country_id
      
      WHERE b.country_name = 'England'
        AND a.posi_to_play = 'GK'
        
      ORDER BY a.player_name ASC;
      
## 12. Write a SQL query that returns the total number of goals scored by each position on each country’s team. Do not include positions which scored no goals.
      WITH goals AS (SELECT goal_id,
                            player_id, 
                            team_id 
                     FROM euro_cup_2016.goal_details)

      SELECT DISTINCT countries.country_name,
                      players.posi_to_play AS position,
                      COUNT(goals.goal_id) OVER(PARTITION BY goals.team_id, players.posi_to_play) AS total_goals_per_position

      FROM goals
      
      INNER JOIN euro_cup_2016.player_mast AS players ON goals.player_id = players.player_id
      
      INNER JOIN euro_cup_2016.soccer_country AS countries ON goals.team_id = countries.country_id
      
      ORDER BY countries.country_name ASC, position ASC;
      
## 13. Write a SQL query to find all the defenders who scored a goal for their teams.
      SELECT DISTINCT players.player_name,
                      positions.position_desc AS position
                      
      FROM euro_cup_2016.player_mast AS players
      
      INNER JOIN euro_cup_2016.goal_details AS goals ON players.player_id = goals.player_id
      
      INNER JOIN euro_cup_2016.playing_position AS positions ON players.posi_to_play = positions.position_id
      
      WHERE positions.position_desc = 'Defenders'
        AND goals.goal_id > 0
        
      ORDER BY players.player_name ASC;
      
## 14. Write a SQL query to find referees and the number of bookings they made for the entire tournament. Sort your answer by the number of bookings in descending order.
      WITH penalties AS (SELECT match_no
                         FROM euro_cup_2016.player_booked)

      SELECT DISTINCT referees.referee_name,
                      COUNT(penalties.match_no) OVER(PARTITION BY matches.referee_id) AS total_bookings_issued

      FROM penalties

      INNER JOIN euro_cup_2016.match_mast AS matches ON penalties.match_no = matches.match_no

      INNER JOIN euro_cup_2016.referee_mast AS referees ON matches.referee_id = referees.referee_id

      ORDER BY total_bookings_issued DESC, referees.referee_name ASC;

## 15. Write a SQL query to find the referees who booked the most number of players.
      WITH penalties AS (SELECT match_no
                         FROM euro_cup_2016.player_booked)

      SELECT DISTINCT referees.referee_name,
                      COUNT(penalties.match_no) OVER(PARTITION BY matches.referee_id) AS total_bookings_issued
                      
      FROM penalties

      INNER JOIN euro_cup_2016.match_mast AS matches ON penalties.match_no = matches.match_no
      
      INNER JOIN euro_cup_2016.referee_mast AS referees ON matches.referee_id = referees.referee_id

      ORDER BY total_bookings_issued DESC, referees.referee_name ASC

      LIMIT 2;
      
## 16. Write a SQL query to find referees and the number of matches they worked in each venue.
      WITH matches AS (SELECT match_no,
                              referee_id,
                              venue_id
                       FROM euro_cup_2016.match_mast)

      SELECT DISTINCT referees.referee_name,
                      venues.venue_name,
                      COUNT(match_no) OVER(PARTITION BY matches.venue_id, matches.referee_id) AS matches_per_venue
                      
      FROM matches
      
      INNER JOIN euro_cup_2016.referee_mast AS referees ON matches.referee_id = referees.referee_id
      
      INNER JOIN euro_cup_2016.soccer_venue AS venues ON matches.venue_id = venues.venue_id

      ORDER BY referees.referee_name ASC, venues.venue_name ASC, matches_per_venue DESC;
      
## 17. Write a SQL query to find the country where the most assistant referees come from, and the count of the assistant referees.
      WITH assistants AS (SELECT ass_ref_id,
                                 ass_ref_name,
                                 country_id,
                                 COUNT(ass_ref_name) OVER() AS total_ass_ref_count
                          FROM euro_cup_2016.asst_referee_mast)
                          
      SELECT COUNT(ass_ref_id) AS most_ass_refs_from,
             countries.country_name,
             total_ass_ref_count
             
      FROM assistants
      
      INNER JOIN euro_cup_2016.soccer_country AS countries ON assistants.country_id = countries.country_id
      
      GROUP BY countries.country_name
      
      ORDER BY most_ass_refs_from DESC
      
      LIMIT 1;
      
## 18. Write a SQL query to find the highest number of foul cards given in one match.
      WITH fouls AS (SELECT DISTINCT COUNT(match_no) OVER(PARTITION BY match_no) AS num_fouls,
                                     match_no
          FROM euro_cup_2016.player_booked)
          
      SELECT MAX(num_fouls) AS most_fouls_in_a_game
      
      FROM fouls;
      
## 19. Write a SQL query to find the number of captains who were also goalkeepers.
      SELECT COUNT(player_id) AS goalkeeper_captains
      
      FROM euro_cup_2016.player_mast AS players
      
      INNER JOIN euro_cup_2016.match_captain AS captains ON players.player_id = captains.player_captain
      
      WHERE posi_to_play = 'GK';
      
## 20. Write a SQL query to find the substitute players who came into the field in the first half of play, within a normal play schedule.
      SELECT DISTINCT players.player_name AS subs_in_first_half_of_normal_play
      
      FROM euro_cup_2016.player_in_out AS subs
      
      INNER JOIN euro_cup_2016.player_mast AS players ON subs.player_id = players.player_id
      
      WHERE in_out = 'I'
        AND play_half = 1
        AND play_schedule = 'NT';
