@Quotes = new Meteor.Collection "quotes"
#Quotes.insert({text: "text', submitted:"formatted-date" })

#Template logic
if Meteor.isClient

  Template.quoteEnter.preserve ['.quote-enter']

  Template.quotes.quoteList = @Quotes.find({}, sort: submitted: -1  )

  Template.quote.submitted_formatted = -> if this.submitted? then moment(this.submitted).fromNow() else 'NO DATA'

  Template.quoteEnter.entering = () ->
    Session.get 'entering'

  Template.quoteEnter.events
    'click .submit':
      (event, template) ->
        text = $(template.find '.quote-enter').val()        
        if text is ''
          Session.set 'entering-errors',true
        else
          console.log moment().valueOf()
          Quotes.insert text: text, submitted: moment().valueOf()
          $(template.find '.quote-enter').val('')

  Template.quoteEnter.errors = () ->
    Session.get 'entering-errors'