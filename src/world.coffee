
class World

  streets: [
    [1,1,1,1,1],
    [1,0,1,0,1],
    [1,1,1,1,1],
    [1,0,1,0,1],
    [1,1,1,1,1]
  ]

  traffic: []

  constructor: (@element) ->
    WIDTH = @element.width()
    HEIGHT = @element.height()

    VIEW_ANGLE = 45
    ASPECT = WIDTH / HEIGHT
    NEAR = 0.1
    FAR = 10000

    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize WIDTH, HEIGHT
    @renderer.setClearColor 0x000000, 1

    @scene = new THREE.Scene()
    @generateCity()

    @camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
    @camera.position.x = -300
    @camera.position.y = 300
    @camera.lookAt new THREE.Vector3 0, 0, 0
    @scene.add @camera

    @element.append @renderer.domElement

  update: ->
    @renderer.render @scene, @camera

  generateCity: ->
    geometry = new THREE.CubeGeometry 100, 1, 100
    streetMaterial = new THREE.MeshBasicMaterial color: 0x666666
    for row, i in @streets
      for col, j in row
        if col is 1
          tile = new THREE.Mesh geometry, streetMaterial
          tile.position.x = i * 100
          tile.position.z = j * 100
          @scene.add tile

    
    
    
