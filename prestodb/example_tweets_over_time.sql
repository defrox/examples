/* total number of tweets by day of week */
SELECT
date_format(try_cast(created AS timestamp), '%W') AS day_of_month,
count(*)
FROM tweets
GROUP BY 1
ORDER BY 2 DESC;

/* total number of tweets by hour of day */
SELECT
date_format(try_cast(created AS timestamp), '%H') AS hour_of_day,
count(*)
FROM tweets
GROUP BY 1
ORDER BY 1 ASC;

/* last 10 tweets */
SELECT created, message
FROM tweets
ORDER BY created DESC
LIMIT 10;

/* top 10 hashtags */
SELECT json_parse(upper(hashtags)), count(*)
FROM tweets
WHERE hashtags IS NOT NULL
AND upper(hashtags) NOT LIKE '%\U%' -- junk filter
AND json_array_length(json_parse(hashtags)) > 0
GROUP BY json_parse(upper(hashtags))
ORDER BY 2 DESC
LIMIT 10;

/* top 10 hashtags by month */
SELECT hashtags, month, thecount,
rank() over (PARTITION BY month ORDER BY thecount DESC) AS rnk
FROM
(
    SELECT date_format(try_cast(created AS timestamp), '%b') AS month,
    json_parse(upper(hashtags)) AS hashtags,
    count(*) AS thecount
    FROM tweets
    WHERE hashtags IS NOT NULL
    AND upper(hashtags) NOT LIKE '%\U%' -- junk filter
    AND json_array_length(json_parse(hashtags)) > 0
    GROUP BY
    date_format(try_cast(created as timestamp), '%b'),
    json_parse(upper(hashtags))
    HAVING count(*) > 1
) LIMIT 10;
