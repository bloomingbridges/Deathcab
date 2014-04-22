
class Vehicle

  forwards:  D.EAST
  topSpeeds: [0, 10, 30, 50, 100]
  waypoints: [] 
  gear: 0

  constructor: (material, @driver = "Anonymous") ->
    if material
      material = new THREE.MeshBasicMaterial
        color: material
        wireframe: true
    else
      material = M.vehicle
    @mesh = new THREE.Mesh G.vehicle, material
    @mesh.position.y = 25

  update: (dT) ->
    @mesh.position.x += @forwards[0] * @getSpeed() * dT
    @mesh.position.z += @forwards[1] * @getSpeed() * dT
    @trace()

  getSpeed: ->
    return @topSpeeds[@gear]

  place: (@sectorX, @sectorZ, @forwards = D.EAST) ->
    @mesh.position.x = @sectorX * 100
    @mesh.position.z = @sectorZ * 100

  determineDirection: ->
    if @waypoints.length > 1
      target = @waypoints.shift()
      direction = [0,0]
      if target.x > @sectorX
        direction[0] = 1
      else if target.x < @sectorX
        direction[0] = -1
      if target.y > @sectorZ
        direction[1] = 1
      else if target.y < @sectorZ
        direction[1] = -1
      # console.log @driver + " : NEW DIRECTION = (#{direction[0]}, #{direction[1]})"
      @forwards = direction
    else
      console.log @driver + " : AIMLESS"
      @gearDown()


  setRoute: (route) =>
    if route
      path = @driver + " : NEW ROUTE = "
      for w in route
        path += "(#{w.x},#{w.y}) -> "
      console.log path + " ..."
      @waypoints = route.slice 1
      @determineDirection()
      if @gear is 0
        @gearUp()
    else
      console.log "NO PATH :<"
      A.calculate()

  trace: ->
    x = Math.floor(@mesh.position.x / 100)
    if x != @sectorX
      @sectorX = x
      E.trigger 'tracking', @driver, 'X', x
      @determineDirection()

    z = Math.floor(@mesh.position.z / 100)
    if z != @sectorZ
      @sectorZ = z
      E.trigger 'tracking', @driver, 'Y', z
      @determineDirection()

    if @waypoints.length >= 1
      if x is @waypoints[0].x and z is @waypoints[0].y
        console.log @driver + " : WAYPOINT REACHED"
        @waypoints = @waypoints.slice 1


  setGear: (newGear) ->
    @gear = newGear unless newGear > 4

  gearUp: ->
    @gear = @gear + 1 unless (@gear + 1 > 4)

  gearDown: ->
    @gear = @gear - 1 unless (@gear - 1 < 0)
