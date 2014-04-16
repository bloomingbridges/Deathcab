
class Deathcab
  
  constructor: ->
    console.log "Welcome to d e a t h c a b"
    @world = new World $('#scenery')
    @prompt = new Prompt $('#prompt')
    @update()
  
  update: =>
    @world.update()
    @rAFID = requestAnimationFrame @update


#
# Entry Point (DOM ready)
#

$ -> new Deathcab
