handle = Meteor.subscribeWithPagination "quotes", 12

@Quotes = new Meteor.Collection "quotes"

Template.mainTemplate.isMobile = () ->
  'ontouchstart' in document.documentElement or window.TouchEvent? or window.Touch?

Template.quotes.quoteList = Quotes.find({}, sort: submitted: -1 )

Template.quoteEnter.preserve ['.quote-enter']

Template.quote.submitted_formatted = -> if this.submitted? then moment(this.submitted).fromNow() else 'NO DATA'

Template.quoteEnter.entering = () ->
  Session.get 'entering'

Template.quoteEnter.errors = () ->
  !!Session.get 'entering-errors'

Template.quoteEnter.blankError = () ->
  (Session.get 'entering-errors') is 'blankError'

Template.quoteEnter.tooLongError = () ->
  (Session.get 'entering-errors') is 'tooLongError'

submitQuote = (template) ->
  text = $(template.find '.quote-enter').val()
  if text is ''
    Session.set 'entering-errors', 'blankError'
  else if text.length > 160
    Session.set 'entering-errors', 'tooLongError'
  else
    Session.set 'entering-errors', false
    Meteor.call('addQuote', text)
    $(template.find '.quote-enter').val('')


Template.quoteEnter.events
  'keypress .quote-enter': (event, template) ->
    if event.which is 13
      submitQuote(template)
  'click .submit': (event, template) ->
    submitQuote(template)
    

Template.loadMore.events
  'click .load-more': () ->
    handle.loadNextPage()