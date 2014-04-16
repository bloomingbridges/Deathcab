
class Deathcab
  
  constructor: ->
    console.log "Welcome to d e a t h c a b"
    @world = new World $('#scenery')
    @prompt = new Prompt $('#prompt')
    E.bind 'choice', @mediate
    @update()
  
  mediate: (choice) =>
    if (choice is "life" || choice is "death")
      @start()
    else if (choice is "stop")
      @world.taxi.setGear 0

  start: =>
    $('#intro').css 'opacity', 0
    $('#hints').addClass 'visible'
    $('#scenery').removeClass 'dimmed'
    @prompt.expandOptions()
    @prompt.wipe()
    @world.taxi.setGear 1
    
  update: =>
    @world.update()
    @rAFID = requestAnimationFrame @update


#
# Entry Point (DOM ready)
#

$ -> new Deathcab
