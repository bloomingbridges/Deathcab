
#
# Entry Point
#

$ ->
  console.log "Welcome to d e a t h c a b"
  setupScenery()
  bindChoiceHandler()
  $('#prompt').focus()

#
# Functions
#

bindChoiceHandler = ->
  $('#prompt').on 'keyup', (event) ->
    choice = $(event.target).val()
    if (choice is "life" || choice is "death")
      mode = choice
      $(event.target).off()
      clearPrompt()
      $('#intro').css 'opacity', 0
      $('#hints').addClass 'visible'
      $('#scenery').removeClass 'dimmed'
  $('#prompt_container').on 'click', (event) ->
    $('#prompt').focus()
  $('#prompt').on 'focus', (event) ->
    $('#prompt_container').addClass 'active'
  $('#prompt').on 'blur', (event) ->
    $('#prompt_container').removeClass 'active'
  $('#prompt_container').trigger 'click'

clearPrompt = ->
  $('#prompt input').val ""

setupScenery = ->
  scenery = $('#scenery')
  WIDTH = scenery.width()
  HEIGHT = scenery.height()

  VIEW_ANGLE = 45
  ASPECT = WIDTH / HEIGHT
  NEAR = 0.1
  FAR = 10000

  renderer = new THREE.WebGLRenderer()
  renderer.setSize WIDTH, HEIGHT
  renderer.setClearColor 0x000000, 1

  scene = new THREE.Scene()

  camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
  camera.position.z = 300
  scene.add camera

  taxi = new Taxi()
  scene.add taxi.mesh

  scenery.append renderer.domElement
  renderer.render scene, camera

