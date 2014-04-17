
#
# World Maps
#

W = 
  BLOCK: 
    width: 5
    height: 5
    tiles: [
      [0,0,0,0,0],
      [0,5,0,5,0],
      [0,0,0,0,0],
      [0,5,0,5,0],
      [0,0,0,0,0]
    ]

  DEFAULT:
    width: 15
    height: 9
    tiles: [
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,5,0,5,0,5,5,0,5,0,5,5,5,5,0],
      [0,0,0,0,0,5,5,0,5,0,0,0,0,0,0],
      [0,5,0,5,0,5,5,0,0,0,5,5,5,5,0],
      [0,0,0,0,0,0,0,0,5,0,0,0,0,0,0],
      [0,5,0,5,0,5,5,0,5,0,5,5,0,5,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,5,0],
      [0,5,0,5,0,5,5,0,5,0,5,5,5,5,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    ]

  ATHENS:
    width: 1
    height: 1
    tiles: [[1]]


#
# Directions
#

D =
  NORTH: [1,0]
  EAST: [0,1]
  SOUTH: [-1,0]
  WEST: [0,-1]


#
# THREE.js Prefabs
#
# Hold geometry and material declarations respectively
#

G =
  vehicle: new THREE.SphereGeometry 10, 8, 1
  street: new THREE.CubeGeometry 110, 1, 110
  building: new THREE.CubeGeometry 100, 100, 100

M =
  vehicle: new THREE.MeshBasicMaterial
    color: 0xFFFFFF
    wireframe: true
  taxi: new THREE.MeshBasicMaterial color: 0xFFB300
  street: new THREE.MeshBasicMaterial color: 0x151515
  building: new THREE.MeshLambertMaterial color: 0x666666


#
# Events
#
# A global object to register custom Events with
#

E =
  events: {}
  bind: (topic, handler, context = this) ->
    (@events[topic] ||= []).push { handler, context }
  trigger: (topic, args...) ->
    if @events[topic]?
      event.handler.apply event.context, args for event in @events[topic]


