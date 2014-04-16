
class Vehicle

  forwards: [1, 0]
  topSpeeds: [0, 10, 30, 50, 100]
  waypoints: [] 
  gear: 0

  constructor: ->
    @mesh = new THREE.Mesh geometries.vehicle, materials.vehicle
    @mesh.position.y = 25

  update: (dT) ->
    @mesh.position.x += @forwards[0] * @getSpeed() * dT
    @mesh.position.z += @forwards[1] * @getSpeed() * dT

  getSpeed: ->
    return @topSpeeds[@gear]

  setGear: (newGear) ->
    @gear = newGear unless newGear > 4
