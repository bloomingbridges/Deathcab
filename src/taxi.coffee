
class Taxi extends Vehicle
  
  _passenger: 
    name: "Howard"

  constructor: ->
    @mesh = new THREE.Mesh G.vehicle, M.taxi
    @mesh.position.y = 25
    @forwards = D.SOUTH

    # @fsm = StateMachine.create
    #   initial: 'parking',
    #   events: [
    #     { name: 'start', from: 'parking', to: 'driving' }
    #     { name: 'stop', from: 'driving', to: 'parking' }
    #   ],
    #   callbacks:
    #     onstart: (event, from, to) ->
    #       console.log "ENTERING " + to
