
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
    
    @taxi = new Taxi()
    @scene.add @taxi.mesh
    
    car = new Vehicle()
    car.mesh.position.z = 200
    car.setGear 1
    @traffic.push car
    @scene.add car.mesh

    @camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
    @camera.position.x = -300
    @camera.position.y = 300
    @camera.lookAt new THREE.Vector3 0, 0, 0
    @scene.add @camera

    @element.append @renderer.domElement

  update: ->
    @taxi.update 0.1
    @camera.lookAt new THREE.Vector3 @taxi.mesh.position.x, 0, @taxi.mesh.position.z
    @manageTraffic()
    @renderer.render @scene, @camera

  manageTraffic: ->
    for car in @traffic
      car.update 0.1

  generateCity: ->
    for row, i in @streets
      for col, j in row
        if col is 1
          tile = new THREE.Mesh geometries.street, materials.street
          tile.position.x = i * 100
          tile.position.z = j * 100
          @scene.add tile
        else if col is 0
          tile = new THREE.Mesh geometries.building, materials.building
          tile.position.x = i * 100
          tile.position.z = j * 100
          tile.position.y = 50
          @scene.add tile

    
    
    
