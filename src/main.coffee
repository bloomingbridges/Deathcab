
fsm = StateMachine.create
  initial: 'parking',
  events: [
    { name: 'start', from: 'parking', to: 'driving' }
    { name: 'stop', from: 'driving', to: 'parking' }
  ],
  callbacks:
    onstart: (event, from, to, mode) ->
      console.log "You choose " + mode

$ ->
  console.log "Welcome to d e a t h c a b"
  setupScenery()
  bindChoiceHandler()
  $('#prompt').focus()

bindChoiceHandler = ->
  $('#prompt').on 'keyup', (event) ->
    choice = $(event.target).val()
    if (choice is "life" || choice is "death")
      mode = choice
      console.log fsm.current
      fsm.start(choice)
      $('#prompt').off()
      $('#intro').css 'opacity', 0

setupScenery = ->
  WIDTH = $(window).width()
  HEIGHT = $(window).height()

  VIEW_ANGLE = 45
  ASPECT = WIDTH / HEIGHT
  NEAR = 0.1
  FAR = 10000

  scenery = $('#scenery')
  renderer = new THREE.WebGLRenderer
  camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR

  scene = new THREE.Scene
  scene.add camera
  camera.position.z = 300
  renderer.setSize WIDTH, HEIGHT

  scenery.append renderer.domElement

