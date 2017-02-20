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

/* Query to extract an array of maps in JSON, from a table called "_message",
   then extract one specific tag from the map, called "text", and unnest each 
   into its own row.  It then performs a GROUP BY and COUNT, and will provide
   a count of those terms.

   Example data in row:

   "entities": {"hashtags": [
                             {"indices": [85, 95], "text": "Idaho"}, 
                             {"indices": [96, 109], "text":"Vermont"}
                            ]
               }

   Example return:

                           extracted_hashtag                        | count
    ----------------------------------------------------------------+-------
     Vermont                                                        | 57468
     Idaho                                                          | 12784
     Texas                                                          |  6912
     Virginia                                                       |  4472
     New Mexico                                                     |  3004

*/
WITH array_of_hashtags AS ( /* extract just the 'text' field from the hashtag map in x */
    WITH array_of_hashtag_arrays AS ( /* extract the hashtags array from json payload in _message column from kafka */
        SELECT try_cast(json_extract(_message, '$.entities.hashtags') AS array<map<varchar,json>>)
        AS hashtag_array
        FROM trumprally
    ) SELECT lower(json_extract_scalar(hashtag['text'], '$')) as extracted_hashtag
      FROM array_of_hashtag_arrays 
      CROSS JOIN UNNEST(hashtag_array) AS h (hashtag) /* unnest array of tags, turning each one into a distinct row */
)
SELECT extracted_hashtag, count(*) as count
FROM array_of_hashtags
GROUP BY extracted_hashtag
ORDER BY count DESC;
