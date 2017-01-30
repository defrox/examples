#!/usr/bin/env python
import json

from vaderSentiment.vaderSentiment import sentiment as vaderSentiment
from kafka import KafkaProducer
import tweepy

CONSUMER_KEY = "my_consumer_key"
CONSUMER_SECRET = "my_consumer_secret"
ACCESS_TOKEN_KEY = "access_token"
ACCESS_TOKEN_SECRET = "access_token_secret"

EVENTADOR_BOOTSTRAP_SERVERS = "server_connect_string_from_eventador_console"
EVENTADOR_KAFKA_TOPIC = "defaultsink"  # leave me
INTERESTEDTAGS = ["#hillaryclinton", "#trump", "#donaldtrump", "#garyjohnson", "#hillary"]


class Kafka(object):
    """ produce data to a kafka endpoint """
    def __init__(self):
        self.producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                                      bootstrap_servers=EVENTADOR_BOOTSTRAP_SERVERS)

    def filterAnalyze(self, i):
        p = {}
        s = {}

        for hashtag in i['entities']['hashtags']:
            if '#'+hashtag['text'].lower() in INTERESTEDTAGS:
                try:
                    s = vaderSentiment(i["text"])
                except:
                    pass
                p["id"] = i["id"]
                p["text"] = i["text"].replace("'", "")
                p["followers_count"] = i["user"]["followers_count"]
                p["hashtag"] = hashtag['text'].lower()
                p["retweeted"] = i["retweeted"]
                p["favorited"] = i["favorited"]
                p["screen_name"] = i["user"]["screen_name"]
                p.update(s)

                # print p
                print "."

        return p

    def produce(self, payload):
        try:
            self.producer.send(EVENTADOR_KAFKA_TOPIC, payload)
        except:
            print "well crud"

        return True


class SentimentStreamListener(tweepy.StreamListener):
    """ listen to twitter """
    def __init__(self):
        self.k = Kafka()

    def on_data(self, data):
        tweet = json.loads(data)
        if "text" in tweet:
            self.k.produce(self.k.filterAnalyze(tweet))
        return data

    def on_status(self, status):
        print(status.text)

    def on_error(self, status_code):
        if status_code == 420:
            print "twitter is throttling..{}".format(error_code)
            return False
        else:
            print "error: {}".format(error_code)
            return False


def main():

    auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
    auth.set_access_token(ACCESS_TOKEN_KEY, ACCESS_TOKEN_SECRET)

    myStreamListener = SentimentStreamListener()
    myStream = tweepy.Stream(auth=auth, listener=myStreamListener)
    myStream.filter(track=INTERESTEDTAGS)

if __name__ == "__main__":
    main()
