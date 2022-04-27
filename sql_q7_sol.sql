SELECT venue.venue_name
FROM euro_cup_2016.match_mast AS mtch

INNER JOIN euro_cup_2016.soccer_venue AS venue ON mtch.venue_id = venue.venue_id

WHERE mtch.decided_by = 'P'