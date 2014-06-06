
class Deathcab

  xcore: false
  
  constructor: ->
    # console.log "Welcome to d e a t h c a b"
    @world = new World $('#scenery'), W.DEFAULT
    @player = @world.taxi
    

    @prompt = new Prompt $('#prompt'), [@gear, @turn, @radio, @changePerspective]
    E('choice').subscribe [@mediate,@]

    #default an autostart in hardcore mode
    @xcore = true
    @start()

    @update()
  
  mediate: (choice) =>
    # if choice is "life" || choice is "death"
    #   @xcore = choice is "death"
    #   @start()
    
    console.log choice
    choice.functions[0].call(this,choice.arguments[0])
    #choice.functions[0] choice.arguments[0]

  start: () =>
    #E('choice').unsubscribe(@mediate)
    $('#intro').css 'opacity', 0
    $('#scenery').removeClass 'dimmed'
    if @xcore
      $('#hud').addClass 'visible'
    else
      $('#hints li.xcore').hide()
      $('#prompt').blur()
      @player.startMeandering()

    $('#hints').addClass 'visible'
    @prompt.expandOptions()

  debugControl: (direction) ->
    if (direction is "up")
      @player.forwards = D.NORTH
    else if (direction is "right")
      @player.forwards = D.EAST
    else if (direction is "down")
      @player.forwards = D.SOUTH
    else if (direction is "left")
      @player.forwards = D.WEST
    @player.automatic = false

  update: =>
    @world.update()
    @rAFID = requestAnimationFrame @update

#
# all the methods for controlling the player
# I think its best to put these in this scope for now because that way you have access to the player and world
#

  turn: {
    possibleFunctions: [
      "turn"
      "go"
      "drive"
    ]
    possibleArguments: [
      "north"
      "south"
      "east"
      "west"
      "left"
      "right"
    ]
    callback: (anArgument) ->
      unless anArgument?
        console.log "turn"
        #$('#hint gear').hide()
      else
        console.log "turn ".concat(anArgument)
        switch anArgument
          when "north" then @player.setHeading D.NORTH
          when "east" then @player.setHeading D.EAST
          when "south" then @player.setHeading D.SOUTH
          when "west" then @player.setHeading D.WEST

          #removed because there is no right left input whooopsss
          #when "right","left" then @player.setHeading anArgument
  }

  radio: {
    possibleFunctions: [
      "radio"
      "tune"
      "turn"
      "change"
      "station"
    ]
    possibleArguments: [
      "on"
      "off"
      "up"
      "down"
    ]
    callback: (anArgument) ->
      unless anArgument?
        console.log "radio"
      else
        console.log "change radio ".concat(anArgument)
      return
  }

  gear: {
    possibleFunctions: [
      "gear"
      "shift"
      "change"
      "go"
    ]
    possibleArguments: [
      "up"
      "down"
      "next"
      "prev"
    ]
    callback: (anArgument) ->
      unless anArgument?
        console.log "change gear"
      else
        console.log "change gear ".concat(anArgument)
        switch anArgument
          when "up", "next" then @player.gearUp()
          when "down", "prev" then @player.gearDown()
        $('#gear').text @player.gear
      return
  }

  changePerspective: {
    possibleFunctions:[
      "debug"
      "person"
      "veiw"
    ]
    possibleArguments:[
      "first"
      "third"
      "true"
      "false"
    ]
    callback: (anArgument) ->
      unless anArgument?
        console.log "debug"
      else
        switch anArgument
          when "first","true" then @world.setFirstPerson true
          when "third","false" then @world.setFirstPerson false
      return
  }



#
# Entry Point (DOM ready)
#

$ -> new Deathcab
