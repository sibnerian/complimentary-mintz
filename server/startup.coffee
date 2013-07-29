Meteor.startup () ->
  collectionApi = new CollectionAPI
    authToken: undefined,              # Require this string to be passed in on each request
    apiPath: 'quotesAPI',          # API path prefix
    standAlone: false,                 # Run as a stand-alone HTTP(S) server
    sslEnabled: false,                 # Disable/Enable SSL (stand-alone only)
    listenPort: 3005,                  # Port to listen to (stand-alone only)
    listenHost: undefined,             # Host to bind to (stand-alone only)

  # Add the collection Players to the API "/players" path
  collectionApi.addCollection Quotes, '',
    # All values listed below are default
    authToken: undefined,                   # Require this string to be passed in on each request
    methods: ['POST','GET','PUT','DELETE'],  # Allow creating, reading, updating, and deleting
    before:   # This methods, if defined, will be called before the POST/GET/PUT/DELETE actions are performed on the collection. If the function returns false the action will be canceled, if you return true the action will take place.
      POST: -> false,  # function(obj) {return true/false;},
      GET: -> true,  # function(collectionID, objs) {return true/false;},
      PUT: -> true,  #function(collectionID, obj, newValues) {return true/false;},
      DELETE: ->true,  #function(collectionID, obj) {return true/false;}

  collectionApi.start()
  return
