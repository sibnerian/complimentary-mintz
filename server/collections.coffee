@Quotes = new Meteor.Collection "quotes"
#Quotes.insert({text: "text', submitted:"formatted-date" })

Meteor.publish "quotes", ->
  return Quotes.find({})