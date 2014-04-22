
class Taxi extends Vehicle
  
  _passenger: 
    name: "Howard"

  constructor: ->
    @mesh = new THREE.Mesh G.vehicle, M.taxi
    @mesh.position.y = 25
    @driver = "Player"
    @place 0, 1, D.SOUTH
    @waypoints = [{
        x: 0
        y: 2
    }]


  trace: ->
    super()
    E.trigger 'tracking'


  setRoute: (route) ->
    if route
      if route.length > 0
        path = @driver + " : NEW ROUTE = "
        for w in route
          path += "(#{w.x},#{w.y}) -> "
        console.log path + " ..."
        @waypoints.push route
        @determineDirection()
        if @gear is 0
          @gearUp()


  # @fsm = StateMachine.create
  #   initial: 'parking',
  #   events: [
  #     { name: 'start', from: 'parking', to: 'driving' }
  #     { name: 'stop', from: 'driving', to: 'parking' }
  #   ],
  #   callbacks:
  #     onstart: (event, from, to) ->
  #       console.log "ENTERING " + to
