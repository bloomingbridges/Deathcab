
class World

  streets: [
    1,1,1,1,1,
    1,0,1,0,1,
    1,1,1,1,1,
    1,0,1,0,1,
    1,1,1,1,1
  ]

  traffic: []

  constructor: (canvas) ->
    @element = canvas
    WIDTH = canvas.width()
    HEIGHT = canvas.height()

    VIEW_ANGLE = 45
    ASPECT = WIDTH / HEIGHT
    NEAR = 0.1
    FAR = 10000

    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize WIDTH, HEIGHT
    @renderer.setClearColor 0x000000, 1

    @scene = new THREE.Scene()

    @camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
    @camera.position.z = 300
    @scene.add @camera

    @element.append @renderer.domElement

  update: () ->
    @renderer.render @scene, @camera