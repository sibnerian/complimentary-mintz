Complimentary Mintz
===================

### Meteor quote repository with convenient API!

#### Live version
If you just want to see a live version of the site, head to [complimentary-mintz.meteor.com](http://complimentary-mintz.meteor.com/).
To access the API, visit [complimentary-mintz.meteor.com/quotesAPI](http://complimentary-mintz.meteor.com/quotesAPI).
If you want to see how the code works (or make a few tweaks and use it for a different professor!), read on.

#### Configuration
Due to the fact that I don't want my Twitter credentials up on Github, you have to do some legwork to get a copy of this 
up and running. All you need to do is add a folder called `server/secret` containing a file called `auth.coffee`. 

This file should look like: 
```
@TWIT_AUTH =
  consumer_key: 'your-consumer-key',
  consumer_secret: 'your-consumer-secret', 
  access_token: 'your-access-token',
  access_token_secret: 'your-access-token-secret'

@SECRET_PASSWORD = 'you can use this to remove crap from the database'
```

Use this file to store any other secret stuff that you need for production, but don't want anyone to see.

#### Running the code

If you already have Meteorite, you're golden! To get a local server up and running, just do
```
mrt install
mrt
```
If you DON'T - you should [install it](https://github.com/oortcloud/meteorite).

#### Making changes
Complimentary Mintz searches Twitter every 20 seconds for more relevant tweets using the `searchForTweets` function in `server/tweeter.coffee`.
If you want to search for different keywords, all you need to do is modify the `searchTerms` array located in the same file.
You can also use getUserTweets to include all tweets made by a certain user - in the case of the Mintz site, this user is @MaxMintzzz.
All keywords specified this way will be filtered out of the published results.

You'll probably want to change the HTML too. This is pretty self-explanatory, since all you'll need to change is the description.
Open up `complimentary-mintz.html` and go to town.

#### API
Of course, this site would be fairly boring without an API. The API provides a convenient endpoint to grab
a large list of Mintz quotes, which can then be used (for example) as filler data for other projects. This endpoint is
`/quotesAPI` by default. You can change this endpoint if you want by changing the apiPath parameter in `server/startup.coffee`
