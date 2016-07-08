-- average temperature by hour of day
CREATE CONTINUOUS VIEW brewery_temps_by_hourofday AS
SELECT date_part('hour', arrival_timestamp) as ts,
avg((payload->>'temp'::text)::numeric)
FROM brewery_stream
GROUP BY ts;
