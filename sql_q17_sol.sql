WITH assistants AS (SELECT
						ass_ref_id,
                        ass_ref_name,
                        country_id,
                        COUNT(ass_ref_name) OVER() AS total_ass_ref_count
					FROM euro_cup_2016.asst_referee_mast)
SELECT
	COUNT(ass_ref_id) AS most_ass_refs_from,
    countries.country_name,
    total_ass_ref_count
FROM assistants
INNER JOIN euro_cup_2016.soccer_country AS countries ON assistants.country_id = countries.country_id
GROUP BY countries.country_name
ORDER BY most_ass_refs_from DESC
LIMIT 1;