-- average temperature of sensors over the last 5 minutes by sensor name
CREATE CONTINUOUS VIEW brewery_sensor_temps WITH (max_age = '5 minutes') AS
SELECT payload->>'sensor' as sensor,
AVG((payload->>'temp'::text)::numeric)
FROM defaultsink_stream
GROUP BY payload->>'sensor';
