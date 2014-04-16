
class Deathcab

  xcore: false
  
  constructor: ->
    console.log "Welcome to d e a t h c a b"
    @world = new World $('#scenery')
    @prompt = new Prompt $('#prompt')
    E.bind 'choice', @mediate
    @update()
  
  mediate: (choice) =>
    @prompt.wipe()
    if (choice is "life" || choice is "death")
      @xcore = choice is "death"
      @start()
    else if (choice is "stop")
      @world.taxi.setGear 0
      $('#gear').text 0
    else if (choice is "up")
      @world.taxi.forwards = [1,0]
    else if (choice is "right")
      @world.taxi.forwards = [0,1]
    else if (choice is "down")
      @world.taxi.forwards = [-1,0]
    else if (choice is "left")
      @world.taxi.forwards = [0,-1]
    else if (choice is "change gear to ?")
      @world.taxi.setGear Math.floor(Math.random() * 5)
      $('#gear').text @world.taxi.gear

  start: () =>
    $('#intro').css 'opacity', 0
    $('#scenery').removeClass 'dimmed'
    if @xcore
      $('#hud').addClass 'visible'
    else
      $('#hints li.xcore').hide()
      $('#prompt').blur()
      @world.taxi.setGear 1
    $('#hints').addClass 'visible'
    @prompt.expandOptions()

  update: =>
    @world.update()
    @rAFID = requestAnimationFrame @update


#
# Entry Point (DOM ready)
#

$ -> new Deathcab
