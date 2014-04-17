
#
# World Maps
#

W = 
  block: 
    width: 5
    height: 5
    tiles: [
      [0,0,0,0,0],
      [0,5,0,5,0],
      [0,0,0,0,0],
      [0,5,0,5,0],
      [0,0,0,0,0]
    ]

  default:
    width: 15
    height: 9
    tiles: [
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,5,0,5,0,5,5,0,5,0,5,0,5,0,0],
      [0,0,0,0,0,5,5,0,5,0,0,0,0,0,0],
      [0,5,0,5,0,5,5,0,0,0,5,0,5,0,0],
      [0,0,0,0,0,0,0,0,5,0,0,0,0,0,0],
      [0,5,0,5,0,5,0,0,5,0,5,0,5,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,5,0,5,0,5,0,0,5,0,5,0,5,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    ]

  athens:
    width: 1
    height: 1
    tiles: [[1]]


#
# THREE.js Prefabs
#
# Hold geometry and material declarations respectively
#

G =
  vehicle: new THREE.SphereGeometry 10, 8, 1
  street: new THREE.CubeGeometry 100, 1, 100
  building: new THREE.CubeGeometry 100, 100, 100

M =
  vehicle: new THREE.MeshBasicMaterial
    color: 0xFFFFFF
    wireframe: true
  taxi: new THREE.MeshBasicMaterial color: 0xFFB300
  street: new THREE.MeshBasicMaterial color: 0x666666
  building: new THREE.MeshBasicMaterial color: 0x151515


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