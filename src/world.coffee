
class World

  traffic: []

  constructor: (@element, map) ->
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
    if map
      @tilesX = map.width
      @tilesZ = map.height
      @tiles = map.tiles
    else
      @generateWorldMap 5, 9
    @placeTiles()
    
    @taxi = new Taxi
    @scene.add @taxi.mesh
    
    car = new Vehicle
    car.mesh.position.z = 200
    car.setGear 1
    @traffic.push car
    @scene.add car.mesh

    @camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
    @camera.position.x = -300
    @camera.position.y = 450
    @camera.lookAt new THREE.Vector3 0, 0, 0
    @scene.add @camera

    @moon = new THREE.DirectionalLight 0x413447
    @moon.intensity = 2.0
    @moon.position.set(-1, 1, 0.5)
    @scene.add @moon

    @clock = new THREE.Clock

    @element.append @renderer.domElement

  update: ->
    deltaTime = @clock.getDelta()
    @taxi.update deltaTime
    @manageTraffic deltaTime
    @camera.position.x = @taxi.mesh.position.x - 300 
    @camera.position.z = @taxi.mesh.position.z
    @camera.lookAt new THREE.Vector3 @taxi.mesh.position.x, 0, @taxi.mesh.position.z
    @renderer.render @scene, @camera

  manageTraffic: (dT) ->
    for car in @traffic
      car.update dT

  generateWorldMap: (width, height) ->
    @tilesX = width
    @tilesY = height
    map = []
    for row in [0..height-1]
      strip = []
      for col in [0..width-1]
        tile = if ((col+1) % 2 is 0) then 5 else 0
        # TODO Add more sophisticated algorithm here
        tile = 0 unless (row+1) % 2 is 0
        strip[col] = tile
      map.push strip
    @tiles = map


  placeTiles: ->
    for row, i in @tiles
      for col, j in row
        if col < 5
          tile = new THREE.Mesh G.street, M.street
          tile.position.x = i * -100
          tile.position.z = j * 100
          @scene.add tile
        else
          tile = new THREE.Mesh G.building, M.building
          tile.position.x = i * -100
          tile.position.y = Math.random() * 50
          tile.position.z = j * 100
          @scene.add tile

    
    
    
