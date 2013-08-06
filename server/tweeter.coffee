Fiber = Npm.require('fibers')
Twit = new TwitMaker TWIT_AUTH

LastTweets = new Meteor.Collection 'last tweets'
LastTweets.deny 
  insert: -> false
  update: -> false
  remove: -> false

runFiber = (func) ->
  (Fiber func).run()

searchTerms = ['#maxmintz', '@MaxMintzzz', '@CompMintz']

filterSearchTerms = (text) ->
  _.reduce(searchTerms, ((base, term) -> base.replace(term, '')), text)

getUserTweets = (screenName) ->
  filter = screen_name: screenName, exclude_replies: true, count: 200, result_type: 'recent'
  lastTweet = LastTweets.findOne {string: screenName}
  if lastTweet? then filter.since_id = lastTweet.since_id
  Twit.get 'statuses/user_timeline', filter, (err, reply) ->
    if err? then console.log err else if reply.length == 0 then console.log "No tweets from #{screenName}" else
      since_id = reply[0].id
      if lastTweet?
        runFiber ->
          LastTweets.update {string: screenName}, {$set: {since_id: since_id}}
      else
        runFiber ->
          LastTweets.insert {string: screenName, since_id: since_id}
      _.each reply.reverse(), (tweet)->
        runFiber ->
          console.log tweet
          Quotes.insert text: filterSearchTerms(tweet.text), submitted: moment(tweet.created_at).valueOf()

searchForTweets = (query) ->
  filter = q: query, count: 100, result_type: 'recent'
  lastFilteredTweet = LastTweets.findOne {string: query}
  if lastFilteredTweet?
    filter.since_id = lastFilteredTweet.since_id
  Twit.get 'search/tweets', filter, (err, reply) ->
    if err? then console.log err else if reply.statuses.length == 0 then console.log "No tweets for #{query}" else
      temp = reply.statuses.pop()
      if reply.statuses.length == 0
        runFiber ->
          if (Quotes.findOne {text: filterSearchTerms(temp.text)})
            console.log "no NEW tweets for #{query}"
          else
            console.log temp.text
            Quotes.insert text: filterSearchTerms(temp.text), submitted: moment(temp.created_at).valueOf()
        return            
      since_id = reply.statuses[0].id
      if lastFilteredTweet? 
        runFiber ->
          LastTweets.update {string: query}, {$set: {since_id: since_id}}
      else
        runFiber ->
          LastTweets.insert {string: query, since_id: since_id}
      _.each reply.statuses.reverse(), (tweet) ->
        runFiber ->
          console.log tweet.text
          Quotes.insert text: filterSearchTerms(tweet.text), submitted: moment(tweet.created_at).valueOf()

Meteor.setInterval () -> 
  _.each(searchTerms, searchForTweets)
  getUserTweets('MaxMintzzz')
, 20*1000