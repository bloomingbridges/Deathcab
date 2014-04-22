
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
      [0,5,0,9,0,5,5,0,5,0,5,5,5,5,0],
      [0,0,0,9,0,5,5,0,5,0,0,0,0,0,0],
      [0,5,0,9,0,5,5,0,0,0,5,5,5,5,0],
      [0,0,0,9,0,0,0,0,5,0,0,0,0,0,0],
      [0,5,0,9,0,5,5,0,5,0,5,5,0,5,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,5,0],
      [0,5,0,9,0,5,5,0,5,0,5,5,5,5,0],
      [0,0,0,9,0,0,0,0,0,0,0,0,0,0,0]
    ]

  ATHENS:
    width: 1
    height: 1
    tiles: [[1]]


#
# Directions
#

D =
  NORTH: [0,-1]
  EAST: [1,0]
  SOUTH: [0,1]
  WEST: [-1,0]


#
# THREE.js Prefabs
#
# Hold geometry and material declarations respectively
#

G =
  vehicle: new THREE.SphereGeometry 10, 8, 1
  street: new THREE.CubeGeometry 110, 20, 110
  building: new THREE.CubeGeometry 100, 100, 100

M =
  vehicle: new THREE.MeshBasicMaterial
    color: 0xFFFFFF
    wireframe: true
  taxi: new THREE.MeshBasicMaterial color: 0xFFB300
  river: new THREE.MeshBasicMaterial color: 0x002244
  street: new THREE.MeshLambertMaterial 
    color: 0x151515
    overdraw: true
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


#
# EasyStar.js - A* Pathfinding Instance
#

A = new EasyStar.js()

