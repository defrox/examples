# Examples for Eventador PrestoDB

A few examples of running SQL in Presto against a sample twitter stream data source.

## Schema

```sql
presto:default> desc tweets;
      Column       |  Type   | Extra |                   Comment
-------------------+---------+-------+---------------------------------------------
 kafka_key         | varchar |       |
 loc               | varchar |       |
 description       | varchar |       |
 friends_count     | varchar |       |
 created           | varchar |       |
 text              | varchar |       |
 topics            | varchar |       |
 hashtags          | varchar |       |
 original_name     | varchar |       |
 followers         | varchar |       |
 id_str            | varchar |       |
 user_created      | varchar |       |
 original_id       | varchar |       |
 message           | varchar |       |
 retweet_count     | varchar |       |
 retweet           | varchar |       |
 name              | varchar |       |
 _partition_id     | bigint  |       | Partition Id
 _partition_offset | bigint  |       | Offset for the message within the partition
 _segment_start    | bigint  |       | Segment start offset
 _segment_end      | bigint  |       | Segment end offset
 _segment_count    | bigint  |       | Running message count per segment
 _key              | varchar |       | Key text
 _key_corrupt      | boolean |       | Key data is corrupt
 _key_length       | bigint  |       | Total number of key bytes
 _message          | varchar |       | Message text
 _message_corrupt  | boolean |       | Message data is corrupt
 _message_length   | bigint  |       | Total number of message bytes
 ```

 ## SQL queries

 All the SQL queries are annotated as to their usage in this directory.
