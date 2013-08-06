@Quotes = new Meteor.Collection "quotes"
#Quotes.insert({text: "text', submitted:"formatted-date" })

Meteor.publish "quotes", (limit) ->
  #Return all quotes sorted by time submitted, breaking ties by _id. Limit is used for the paginated-subscription package.
  return Quotes.find({}, {sort: {submitted: -1, _id: -1}, limit : limit})