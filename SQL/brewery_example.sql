CREATE CONTINUOUS VIEW brewery_sensor_temps
WITH (sw = '5 minutes')
AS
SELECT payload->>'sensor' as sensor,
AVG((payload->>'temp'::text)::numeric)
FROM defaultsink_stream
GROUP BY payload->>'sensor';

CREATE CONTINUOUS VIEW brewery_sensor_temps_by_minute
AS
SELECT date_trunc('minute'::text, arrival_timestamp) AS ts,
payload ->> 'sensor'::text AS sensor,
avg((payload ->> 'temp'::text)::numeric) AS avg
FROM ONLY defaultsink_stream
WHERE arrival_timestamp > (clock_timestamp() - '01:00:00'::interval)
GROUP BY 1,2;
