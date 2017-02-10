-- last 30 minutes of visits to a website
CREATE CONTINUOUS VIEW last_30_visits AS
SELECT COUNT(*) FROM visits_stream
WHERE (arrival_timestamp > clock_timestamp() - interval '30 minutes');
