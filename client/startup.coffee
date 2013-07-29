Meteor.startup () ->
  Meteor.autorun () ->
    document.title = Session.get 'title'
    return