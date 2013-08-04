selectedNode = undefined

unselectNode = () ->
  selectedNode?.removeClass 'selected'


Template.quote.rendered = ->
  $(this.find '.quote-padding').on 'click touchstart', (event)->
    unselectNode()
    $(this).addClass 'selected'
    selectedNode = $(this)
    event.stopPropagation()

$('html').on 'click touchstart', ->
  unselectNode()