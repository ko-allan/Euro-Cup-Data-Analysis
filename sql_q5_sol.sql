SELECT COUNT(play_schedule) AS bookings_in_stoppage_time
FROM euro_cup_2016.player_booked
WHERE play_schedule = 'ST'