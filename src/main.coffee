
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
  $('#prompt input').focus().click (event) ->
    $('#prompt input').focus()

bindChoiceHandler = ->
  $('#prompt').on 'keyup', (event) ->
    choice = $(event.target).val()
    if (choice is "life" || choice is "death")
      mode = choice
      fsm.start(choice)
      $(event.target).off()
      clearPrompt()
      $('#intro').css 'opacity', 0
      $('#hints').addClass 'visible'
      $('#scenery').removeClass 'dimmed'

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

  lineMaterial = new THREE.MeshBasicMaterial
    color: 0xFFFFFF
    wireframe: true
  sphere = new THREE.Mesh(new THREE.SphereGeometry(50, 16, 16), lineMaterial)
  scene.add sphere

  camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
  camera.position.z = 300
  scene.add camera

  scenery.append renderer.domElement
  renderer.render scene, camera

