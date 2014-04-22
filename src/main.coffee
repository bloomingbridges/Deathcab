
class Deathcab

  xcore: false
  
  constructor: ->
    # console.log "Welcome to d e a t h c a b"
    @world = new World $('#scenery'), W.BLOCK
    @player = @world.taxi
    @prompt = new Prompt $('#prompt')
    E.bind 'choice', @mediate
    @update()
  
  mediate: (choice) =>
    @prompt.wipe()
    if choice is "life" || choice is "death"
      @xcore = choice is "death"
      @start()
    else if choice is "next"
      @player.gearUp()
    else if choice is "prev"
      @player.gearDown() 
    else if choice is "stop"
      @player.setGear 0
      $('#gear').text 0
    else if choice is "change gear to ?"
      @player.setGear Math.floor(Math.random() * 5)
      $('#gear').text @player.gear
    else if ["up","right","down","left"].indexOf(choice) >= 0
      @debugControl choice

  start: () =>
    $('#intro').css 'opacity', 0
    $('#scenery').removeClass 'dimmed'
    if @xcore
      $('#hud').addClass 'visible'
    else
      $('#hints li.xcore').hide()
      $('#prompt').blur()
      @player.setGear 2
    $('#hints').addClass 'visible'
    @prompt.expandOptions()

  debugControl: (direction) ->
    if (direction is "up")
      @player.forwards = D.NORTH
    else if (direction is "right")
      @player.forwards = D.EAST
    else if (direction is "down")
      @player.forwards = D.SOUTH
    else if (direction is "left")
      @player.forwards = D.WEST

  update: =>
    @world.update()
    @rAFID = requestAnimationFrame @update


#
# Entry Point (DOM ready)
#

$ -> new Deathcab
