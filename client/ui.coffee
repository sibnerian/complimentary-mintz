selectedNode = undefined

Template.quote.rendered = ->
  $(this.find '.quote-padding').on 'click touchstart', ->
    if selectedNode?
      selectedNode.removeClass 'selected'
    $(this).addClass 'selected'
    selectedNode = $(this)