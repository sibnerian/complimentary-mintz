@Quotes = new Meteor.Collection "quotes"
#Quotes.insert({text: "text', date:"formatted-date" })

#Template logic
if Meteor.isClient

  Template.quoteEnter.preserve ['.quote-enter', '.date']

  Template.quotes.quoteList = @Quotes.find({})
  Template.quoteEnter.entering = () ->
    Session.get 'entering'

  Template.quoteEnter.events
    'click .submit':
      (event, template) ->
        text = $(template.find '.quote-enter').val()
        datetime_raw = $(template.find '.date').val()
        date = moment datetime_raw, 'MM/D/YYYY h:ma'
        if (date.isBefore moment())
          Session.set 'entering-errors', false
          $(template.find '.date').val ''
          $(template.find '.quote-enter').val ''
          Quotes.insert
            text: text
            date: date.format()
        else
          Session.set 'entering-errors',true


  Template.quoteEnter.rendered = () ->
    $(@.find '.date').datetimepicker
      timeFormat: 'h:mmtt'
      stepHour: 1
      stepMinute: 15
      addSliderAccess: true
      sliderAccessArgs: {touchonly : false}

  Template.quoteEnter.errors = () ->
    Session.get 'entering-errors'

if Meteor.isServer
  Meteor.startup () ->
    console.log 'Server started successfully!'