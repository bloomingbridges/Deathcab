
#
# THREE.js
#

geometries =
    vehicle: new THREE.SphereGeometry 10, 8, 1
    street: new THREE.CubeGeometry 100, 1, 100
    building: new THREE.CubeGeometry 100, 100, 100

materials =
    vehicle: new THREE.MeshBasicMaterial
      color: 0xFFFFFF
      wireframe: true
    taxi: new THREE.MeshBasicMaterial color: 0xFFB300
    street: new THREE.MeshBasicMaterial color: 0x666666
    building: new THREE.MeshBasicMaterial color: 0x151515


#
# Events
#

events =
  events: {}
  bind: (topic, handler, context = this) ->
    (@events[topic] ||= []).push { handler, context }
  trigger: (topic, args...) ->
    if @events[topic]?
      event.handler.apply event.context, args for event in @events[topic]