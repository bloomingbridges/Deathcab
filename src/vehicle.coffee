
class Vehicle

  forwards:  D.EAST
  topSpeeds: [0, 10, 30, 50, 100]
  waypoints: [] 
  gear: 0

  constructor: ->
    @mesh = new THREE.Mesh G.vehicle, M.vehicle
    @mesh.position.y = 25

  update: (dT) ->
    @mesh.position.x += @forwards[0] * @getSpeed() * dT
    @mesh.position.z += @forwards[1] * @getSpeed() * dT

  getSpeed: ->
    return @topSpeeds[@gear]

  setGear: (newGear) ->
    @gear = newGear unless newGear > 4

  gearUp: ->
    @gear = @gear + 1 unless (@gear + 1 > 4)

  gearDown: ->
    @gear = @gear - 1 unless (@gear - 1 < 0)
