Meteor.methods
  addQuote: (text) ->
    Quotes.insert {text:text, submitted: moment().valueOf()}
  removeQuote: (query, secretPassWord) -> 
    if SECRET_PASSWORD? and secretPassWord == SECRET_PASSWORD # SECRET_PASSWORD defined in a secret file that YOU CAN'T SEE. It's in /server/secret/secret_password.coffee
      if query.text?
        Quotes.remove query