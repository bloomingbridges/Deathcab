
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

    A.setGrid @tiles
    A.setAcceptableTiles [0]
    A.setIterationsPerCalculation 20
    
    @taxi = new Taxi
    @scene.add @taxi.mesh
    @generateTraffic()
    E.bind 'entering', @calculateOptions

    @camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
    @camera.position.y = 450
    @camera.lookAt new THREE.Vector3 @taxi.mesh.position.x, 0, @taxi.mesh.position.z
    @scene.add @camera

    @moon = new THREE.AmbientLight 0x121246
    @moon.intensity = 1.0
    @scene.add @moon

    @darkness = new THREE.DirectionalLight 0xeeeeff
    @darkness.position.set(@tilesX*-200, 900, @tilesZ*-50)
    @darkness.castShadow = true
    # @darkness.onlyShadow = true
    @darkness.shadowMapWidth = 512
    @darkness.shadowMapHeight = 512
    @scene.add @darkness

    # axes = new THREE.AxisHelper( 2000 )
    # @scene.add axes

    @renderer.shadowMapEnabled = true;
    @renderer.shadowMapType = THREE.PCFShadowMap

    @clock = new THREE.Clock

    @element.append @renderer.domElement


  update: ->
    deltaTime = @clock.getDelta()
    @taxi.update deltaTime
    @camera.position.x = @taxi.mesh.position.x
    @camera.position.z = @taxi.mesh.position.z + 300
    @camera.lookAt new THREE.Vector3 @taxi.mesh.position.x, 0, @taxi.mesh.position.z
    @manageTraffic deltaTime
    @renderer.render @scene, @camera


  generateTraffic: ->

    ghosts = [
      {
        name: "Blinky"
        colour: 0xFF0000
      },
      {
        name: "Pinky"
        colour: 0xFF00CC, 
      },
      {
        name: "Inky"
        colour: 0x00CCFF,
      },
      {
        name: "Clyde"
        colour: 0xCCCC00
      }
    ]

    for g, n in ghosts
      car = new Vehicle g.colour, g.name
      car.place n*2, 0, D.SOUTH
      @traffic.push car
      @scene.add car.mesh
      car.startMeandering()


  calculateOptions: (vehicle) =>
    possibleDirections = []
    for dir in [D.SOUTH, D.EAST, D.WEST, D.NORTH]
      if @adjacentTileReachable vehicle.sectorX, vehicle.sectorZ, dir
        possibleDirections.push dir
    vehicle.setAvailableOptions possibleDirections


  adjacentTileReachable: (x, z, direction) ->
    pX = x + direction[0]
    pZ = z + direction[1]
    if pZ >= 0 and pZ < @tilesZ
      if pX >= 0 and pX < @tilesX
        tile = @tiles[pZ][pX]
        if tile is 0
          console.log "OPTION [#{pX},#{pZ}]"
          return true
        else 
          return false
      else
        return false
    else 
      return false


  manageTraffic: (dT) ->
    for v in @traffic
      v.update dT


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
    height = @tilesZ-1
    for i in [height..0]
      for col, j in @tiles[i]
        if col is 9
          tile = new THREE.Mesh G.street, M.river
          tile.position.x = j * 100 #- 25
          tile.position.y = -25
          tile.position.z = i * 100 #- 25
          tile.receiveShadow = true
          @scene.add tile
        else if col < 5
          tile = new THREE.Mesh G.street, M.street
          tile.position.x = j * 100 #- 25
          tile.position.z = i * 100 #- 25
          tile.receiveShadow = true
          @scene.add tile
        else
          tile = new THREE.Mesh G.building, M.building
          tile.position.x = j * 100 #- 25
          tile.position.y = Math.random() * 45
          tile.position.z = i * 100 #- 25
          tile.receiveShadow = true
          tile.castShadow = true
          @scene.add tile

    
  # generateRandomDestinationForVehicle: (vehicle) ->
    
  #   current = 
  #     x: vehicle.sectorX
  #     y: vehicle.sectorZ

  #   point = 
  #     x: current.x
  #     y: current.y

  #   while isReachable is true
  #     point.x = Math.floor( Math.random() * @tilesX )
  #     point.y = Math.floor( Math.random() * @tilesZ )
  #     if point is not current
  #       if @tiles[z][x] is 0
  #         point.x = x
  #         point.y = z
  #         isReachable = true

  #   console.log vehicle.driver + " : NEW DESTINATION = [#{point.x}, #{point.y}]"
  #   A.findPath vehicle.sectorX, vehicle.sectorZ, point.x, point.y, vehicle.setRoute
  #   A.calculate()


