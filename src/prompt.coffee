
class Prompt

  options: ['life', 'death']

  constructor: (@element) ->
    @bindEventHandlers()
    @element.focus()

  bindEventHandlers: ->
    @element.on 'keyup', @onInput
    @element.on 'focus', @onFocus
    @element.on 'blur', @onFocusLost
    $('#prompt_container').on 'mouseover', @onActivate
    $('#interface').on 'click', @onActivate

  onInput: (event) ->
    choice = $(event.target).val()
    # console.log choice
    if (choice is "life" || choice is "death")
      $('#intro').css 'opacity', 0
      $('#hints').addClass 'visible'
      $('#scenery').removeClass 'dimmed'

  onFocus: (event) ->
    $('#prompt_container').addClass 'active'

  onFocusLost: (event) ->
    $('#prompt_container').removeClass 'active'

  onActivate: (event) ->
    $('#prompt').focus()

  clear = ->
    $(@element).val ""