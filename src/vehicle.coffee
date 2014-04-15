
fsm = StateMachine.create


class Vehicle

  forwards: [1, 0]
  topSpeeds: [0, 10, 30, 50, 100]
  waypoints: [] 
  gear: 0

  constructor: ->
    geometry = new THREE.SphereGeometry 50, 16, 16
    material = new THREE.MeshBasicMaterial
      color: 0xFFFFFF
      wireframe: true
    @mesh = new THREE.Mesh geometry, material

  update: (dT) ->
    @mesh.position.x += forwards[0] * @getSpeed * dT
    @mesh.position.y += forwards[1] * @getSpeed * dT

  getSpeed: ->
    return @topSpeeds[@gear]

  setGear: (newGear) ->
    gear = newGear unless newGear > 4

