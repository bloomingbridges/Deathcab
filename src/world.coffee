
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
    @taxi.sectorZ = @tilesZ-1
    
    car = new Vehicle
    car.mesh.position.x = 100
    car.setGear 1
    @traffic.push car
    @scene.add car.mesh

    car2 = new Vehicle
    car2.mesh.position.z = 100
    car2.forwards = D.SOUTH
    car2.setGear 2
    @traffic.push car2
    @scene.add car2.mesh

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

    axes = new THREE.AxisHelper( 2000 )
    @scene.add axes

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
    @trackTaxi()
    @manageTraffic deltaTime
    @renderer.render @scene, @camera

  trackTaxi: ->
    x = Math.floor(@taxi.mesh.position.x / 100)
    z = Math.floor(@taxi.mesh.position.z / 100)
    
    $('#debug').html "<br />X: " + x + ", Z: " + z
    if x is not @taxi.sectorX
      @taxi.sectorX = x

    if z is not @taxi.sectorZ
      @taxi.sectorZ = z
    #   if z >= @tilesZ * -100 and -z <= 0
    #   else
    #     console.log "OUT OF BOUNDS!"
    #     @taxi.setGear 0

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
          tile.position.x = j * 100
          tile.position.y = -25
          tile.position.z = i * 100
          tile.receiveShadow = true
          @scene.add tile
        else if col < 5
          tile = new THREE.Mesh G.street, M.street
          tile.position.x = j * 100
          tile.position.z = i * 100
          tile.receiveShadow = true
          @scene.add tile
        else
          tile = new THREE.Mesh G.building, M.building
          tile.position.x = j * 100
          tile.position.y = Math.random() * 45
          tile.position.z = i * 100
          tile.receiveShadow = true
          tile.castShadow = true
          @scene.add tile

    
    
    
