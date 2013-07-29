Twit = new TwitMaker TWIT_AUTH
Twit.post 'statuses/update', status: 'Greetings again, world!' , (err, reply) ->
  console.log if err? then err else reply