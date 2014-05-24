
class Vehicle

  forwards: D.EAST
  availableOptions: [D.SOUTH, D.EAST]
  topSpeeds: [0, 10, 30, 50, 100]
  waypoints: []
  gear: 0
  pakku: {}

  constructor: (@material, @driver = "Anonymous") ->
    if material
      material = new THREE.MeshBasicMaterial
        color: material
        wireframe: true
    else
      material = M.vehicle
    @colour = '#' + material.color.getHexString()
    @mesh = new THREE.Mesh G.vehicle, material
    @mesh.position.y = 25
    @meandering = true
    @pakku = new Pakku @driver, @colour


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
    @pakku.log 'sector', "<em>X: #{@sectorX}</em><br /><em>Z: #{@sectorZ}</em>"
    @pakku.log 'direction', "<em>#{D.PARSE @forwards}</em>"


  startMeandering: ->
    @meandering = true
    @setGear 2


  trace: ->
    x = Math.floor( @mesh.position.x / 100 )
    z = Math.floor( @mesh.position.z / 100 )
    if x != @sectorX or z != @sectorZ
      console.log @driver + " : ENTERED = [#{x},#{z}]"
      @pakku.log 'sector', "<em>X: #{x}</em><br /><em>Z: #{z}</em>"
      @previousX = @sectorX
      @previousZ = @sectorZ
      @sectorX = x
      @sectorZ = z
      E('entering').broadcast(@)
      if not @meandering
        @hasReachedWaypoint()


  setDirection: (direction) ->
    if @forwards != direction
      # console.log @driver + " : CHANGED DIRECTION = (#{direction[0]}, #{direction[1]})"
      @pakku.log 'direction', "<em>#{D.PARSE direction}</em>"
      @pakku.log 'message', "COURSE CHANGED"
    else
      @pakku.log 'message', "KEEPING THROUGH"
      # console.log @driver + " : STAYING ON COURSE"
    @forwards = direction
      

  setAvailableOptions: (@availableOptions) ->
    @pakku.log 'options', @availableOptions
    @determineDirection()


  determineDirection: ->
    # console.log @driver + " : ORIENTATING.."
    @pakku.log 'message', "ORIENTATING.."
    if @waypoints.length >= 1
      upcoming = @waypoints[0]
      direction = [0,0]
      if upcoming.x > @sectorX
        direction[0] = 1
      else if upcoming.x < @sectorX
        direction[0] = -1
      if upcoming.y > @sectorZ
        direction[1] = 1
      else if upcoming.y < @sectorZ
        direction[1] = -1
      @setDirection direction
    else
      if @availableOptions.length > 0
        if $.inArray(@forwards, @availableOptions) == -1
          console.log @driver + " : FORWARDS NOT AN OPTION!", @availableOptions
          # TODO Choose the one that isn't backwards
          backwards = [@forwards[0]*-1,@forwards[1]*-1]
          index = $.inArray(backwards, @availableOptions)
          if index >= 0
            console.log "BACKWARDS!", @availableOptions[index]
            @availableOptions.splice index, 1
          r = Math.floor(Math.random() * @availableOptions.length)
          @setDirection @availableOptions[r]
      else
        @setGear 0
        console.log @driver + " : STUCK"


  pushWaypoint: (point) ->
    @waypoints.push point
    @determineDirection() if @waypoints.length is 1


  hasReachedWaypoint: ->
    p = @waypoints[0]
    if p.x is @sectorX and p.y is @sectorZ 
      console.log @driver + " : WAYPOINT REACHED [#{p.x},#{p.y}]"
      @waypoints.splice 0, 1
      if @waypoints.length > 0
        console.log @driver + " : " + @waypoints.length + " MORE! NEXT UP =",
        "[#{@waypoints[0].x}, #{@waypoints[0].y}]"
        @determineDirection()
      else
        @setGear 0
        @meandering = true
      return true
    else
      return false


  setGear: (newGear) ->
    @gear = newGear unless newGear > 4


  gearUp: ->
    @gear = @gear + 1 unless (@gear + 1 > 4)


  gearDown: ->
    @gear = @gear - 1 unless (@gear - 1 < 0)

