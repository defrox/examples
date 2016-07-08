SELECT (payload ->> 'tailnumber'::text) AS tail,                                                                                                                                                   +
        keyed_max("timestamp", concat_ws(','::text, (payload ->> 'lat'::text),
        (payload ->> 'lon'::text))) AS latlong                                                                                   +
FROM ONLY planedemo_stream                                                                                                                                                                       +
WHERE ((arrival_timestamp > (clock_timestamp() - '00:10:00'::interval)) AND ((payload ->> 'lat'::text) <> ''::text))                                                                              +
GROUP BY (payload ->> 'tailnumber'::text)
