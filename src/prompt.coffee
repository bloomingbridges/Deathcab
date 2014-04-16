
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
    $('a[data-hint]').on 'click', @onTrigger

  wipe: ->
    @element.val ""

  expandOptions: ->
    @options = ['stop', 'test']

  onInput: (event) =>
    choice = @element.val()
    if (@options.indexOf(choice) > -1) 
      console.log "CHOICE:", choice
      events.trigger 'choice', choice

  onFocus: (event) =>
    $('#prompt_container').addClass 'active'

  onFocusLost: (event) =>
    $('#prompt_container').removeClass 'active'

  onActivate: (event) =>
    $('#prompt').focus()

  onTrigger: (event) =>
    event.preventDefault()
    @element.val event.target.dataset.hint
    @element.trigger 'keyup'
