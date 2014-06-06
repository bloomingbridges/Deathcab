
#
# World Maps
#

W = 
  BLOCK: 
    width: 5
    height: 3
    tiles: [
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
  # NORTH: [0,-1,Math.PI*.5]
  NORTH: [0,-1,Math.PI*1.5]
  EAST: [1,0,Math.PI*0]
  # SOUTH: [0,1,Math.PI*1.5]
  SOUTH: [0,1,Math.PI*.5]
  WEST: [-1,0,Math.PI*1]

  PARSE: (numbers) ->
    if numbers == D.NORTH
      return "NORTH"
    if numbers == D.EAST
      return "EAST"
    if numbers == D.SOUTH
      return "SOUTH"
    if numbers == D.WEST
      return "WEST"


#
# THREE.js Prefabs
#
# Hold geometry and material declarations respectively
#

S =
  carOptions:
    # this was just kind of figured out through trial and error its doesn't seem to be...
    # ...by pixels like everything else
    amount: 5
    bevelThickness:3;

  carShape: ()->
    carLength = 24
    carHeight = 8
    carShape = new THREE.Shape
    carShape.moveTo 0 - carLength*.5, 0
    carShape.lineTo 0 - carLength*.5, carHeight*.5
    carShape.lineTo carLength*.2 - carLength*.5, carHeight
    carShape.lineTo carLength*.6 - carLength*.5, carHeight
    carShape.lineTo carLength*.8 - carLength*.5, carHeight*.5
    carShape.lineTo carLength - carLength*.5, carHeight*.5
    carShape.lineTo carLength - carLength*.5, 0
    carShape.lineTo 0 - carLength*.5, 0
    carShape

G =
  vehicle: new THREE.ExtrudeGeometry S.carShape(), S.carOptions
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
# Radio
#
# A global radio instance for publishing and subscribing to custom events 
#

E = radio


#
# EasyStar.js - A* Pathfinding Instance
#

A = new EasyStar.js()


#
# Pakku Debugger
#

class Pakku

  constructor: (@id, @colour) ->
    @element = $('<section />', { class: 'info' }).data('pakku', @id)
    @element.append $('<span />', { text: @id, css: { color: @colour } }).data('info', @id)
    @element.append $('<span />', { text: "Sector" }).data('info', 'sector')
    @element.append $('<span />', { text: "Options" }).data('info', 'options')
    @element.append $('<span />', { text: "Direction" }).data('info', 'direction')
    @element.append $('<span />', { text: "" }).data('info', 'message')
    $('#debug').append @element

  log: (node, data) ->
    switch node
      when 'message'
        @element.find("span[data-info=message]").html data
      when 'options'
        optionString = "Options:"
        for o in data
          optionString += "<br /><em>#{D.PARSE o}</em>"
        @element.find("span[data-info=options]").html optionString    
      else
        @element.find("span[data-info=#{node}]").html "#{node}<br />" + data

