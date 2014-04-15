
class Taxi extends Vehicle
  
  passenger: 
    name: "Howard"

  constructor: () ->
    geometry = new THREE.SphereGeometry 50, 16, 16
    material = new THREE.MeshBasicMaterial
      color: 0xFFB300
    @mesh = new THREE.Mesh geometry, material

    @fsm = StateMachine.create
      initial: 'parking',
      events: [
        { name: 'start', from: 'parking', to: 'driving' }
        { name: 'stop', from: 'driving', to: 'parking' }
      ],
      callbacks:
        onstart: (event, from, to, mode) ->
          console.log "ENTERING " + mode
