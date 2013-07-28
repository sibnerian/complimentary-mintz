Meteor.startup () ->
  Meteor.autorun () ->
    document.title = Session.get 'title'
    return
  return


Session.set "title", "Complimentary Mintz"
Session.set 'entering', true
Session.set 'entering-errors', false