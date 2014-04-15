
world = new World $('#scenery')
taxi = new Taxi()
world.scene.add taxi.mesh
prompt = new Prompt $('#prompt')
  
update = ->
  world.update()
  rAFID = requestAnimationFrame update

#
# Entry Point
#

$ ->
  console.log "Welcome to d e a t h c a b"
  rAFID = requestAnimationFrame update
  $('#prompt_container').on 'click', (event) ->
    $('#prompt').focus()
