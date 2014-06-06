
class Taxi extends Vehicle
  
  _passenger: 
    name: "Howard"

  constructor: ->
    @mesh = new THREE.Mesh G.vehicle, M.taxi
    @mesh.position.y = 25
    @driver = "Player"
    @pakku = new Pakku @driver, 'aquamarine'
    @place 0, 0, D.EAST
    @meandering = true
    @automatic = true
    @gear = 3

    # @waypoints = [
    #   { x: 0, y: 2 },
    #   { x: 1, y: 2 },
    #   { x: 2, y: 2 },
    #   { x: 2, y: 3 },
    #   { x: 2, y: 4 },
    #   { x: 1, y: 4 },
    #   { x: 0, y: 4 },
    #   { x: 0, y: 3 },
    # ]


  setRoute: (route) ->
    path = @driver + " : NEW ROUTE = "
    for w in route
      path += "(#{w.x},#{w.y}) -> "
    console.log path + " ..."
    @waypoints.push route
    @determineDirection()
    if @gear is 0
      @gearUp()

  setAvailableOptions: (@availableOptions) ->
    @pakku.log 'options', @availableOptions
    @determineDirection() if @meandering and @automatic

  getFocalPoint: ->
    dist = 100
    pov = new THREE.Vector3 @mesh.position.x+Math.cos(@forwards[2])*dist, @mesh.position.y, @mesh.position.z+Math.sin(@forwards[2])*dist
    return pov

  # @fsm = StateMachine.create
  #   initial: 'parking',
  #   events: [
  #     { name: 'start', from: 'parking', to: 'driving' }
  #     { name: 'stop', from: 'driving', to: 'parking' }
  #   ],
  #   callbacks:
  #     onstart: (event, from, to) ->
  #       console.log "ENTERING " + to
