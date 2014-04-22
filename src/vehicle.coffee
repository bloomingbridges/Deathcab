
class Vehicle

  forwards: D.EAST
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
    @meandering = false


  update: (dT) ->
    @mesh.position.x += @forwards[0] * @getSpeed() * dT
    @mesh.position.z += @forwards[1] * @getSpeed() * dT
    if @gear > 0
      @trace()


  getSpeed: ->
    return @topSpeeds[@gear]


  place: (@sectorX, @sectorZ, @forwards = D.EAST) ->
    @mesh.position.x = @sectorX * 100
    @mesh.position.z = @sectorZ * 100


  startMeandering: ->
    @meandering = true
    @setGear 2


  determineDirection: ->
    if @waypoints.length >= 1
      target = @waypoints[0]
      direction = [0,0]
      if target.x > @sectorX
        direction[0] = 1
      else if target.x < @sectorX
        direction[0] = -1
      if target.y > @sectorZ
        direction[1] = 1
      else if target.y < @sectorZ
        direction[1] = -1
      console.log @driver + " : NEW DIRECTION = (#{direction[0]}, #{direction[1]})"
      @forwards = direction


  pushWaypoint: (point) ->
    @waypoints.push point
    @determineDirection()


  hasReachedWaypoint: ->
    p = @waypoints[0]
    if p.x is @sectorX and p.y is @sectorZ 
      console.log @driver + " : WAYPOINT REACHED"
      return true
    else
      return false


  hasReachedFinalWaypoint: ->
    if @waypoints.length is 1
      return @hasReachedWaypoint()
    else
      return false


  trace: ->
    x = Math.floor( @mesh.position.x / 100 )
    if x != @sectorX
      @sectorX = x

    z = Math.floor( @mesh.position.z / 100 )
    if z != @sectorZ
      @sectorZ = z

    if @waypoints.length > 1 and @hasReachedWaypoint()
      @waypoints.splice 0, 1
      @determineDirection()


  setGear: (newGear) ->
    @gear = newGear unless newGear > 4


  gearUp: ->
    @gear = @gear + 1 unless (@gear + 1 > 4)


  gearDown: ->
    @gear = @gear - 1 unless (@gear - 1 < 0)

