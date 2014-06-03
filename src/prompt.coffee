
class Prompt

  options: ['life', 'death']

  constructor: (@element, @allActions) ->
    @bindEventHandlers()
    @element.focus()

  bindEventHandlers: ->
    @element.on 'keydown', @onInput
    @element.on 'focus', @onFocus
    @element.on 'blur', @onFocusLost
    $('#prompt_container').on 'mouseover', @onActivate
    $('#interface').on 'click', @onActivate
    $('a[data-hint]').on 'click', @onTrigger

  wipe: ->
    @element.val ""

  expandOptions: ->
    @options = ['auto', 'next', 'prev', 'stop', 'up', 'right', 'down', 'left', 'change gear to ?']

  onInput: (event) =>
      # set choice to lower case
      choice = @element.val().toLowerCase()

      # pass choise through gess action
      guess = @guessAction(choice)
       
      
      # this is a little thing to acoomidate for mode selction now
      if @options.length is 2
        if (@options.indexOf(choice) > -1) 
          console.log "CHOICE:", choice
          E('choice').boradcast choice
      else
        # pass guess object to suggestions listener
        # E.trigger 'suggest', guess

        # if return is pressed
        if event.keyCode is 13
          # clear the element
          @wipe()
          # if there is one guess
          #if guess.functions.length is 1 and guess.arguments.length is 1
          E('choice').broadcast guess

  onFocus: (event) =>
      $('#prompt_container').addClass 'active'

  onFocusLost: (event) =>
    $('#prompt_container').removeClass 'active'

  onActivate: (event) =>
    $('#prompt').focus()

  onTrigger: (event) =>
    event.preventDefault()
    @element.val event.target.dataset.hint
    @element.trigger 'keydown'

  guessAction: (input) ->
    # set to lowercase
    string = input.toLowerCase()
    space = " "
    string = string.concat space
    console.log "string= " + string
    
    # for each action check to see if the word sum the present words

    result = 
      functions: new Array()
      arguments: new Array()

    matchSum = new Array(@allActions.length)
    i = 0

    console.log @gear
    console.log @allActions

    while i < @allActions.length
      matchSum[i] = @sumKeywordMatches(@allActions[i].possibleFunctions.concat(@allActions[i].possibleArguments), string)
      i++
    console.log "matchSum= " + matchSum
    
    # get the most likey action
    actionIndex = @getLargestIndex(matchSum)
    
    # check to see if there are any other matching cases
    equalActionIdexes = @equalIndexArray(matchSum, actionIndex)
    equalActionsTotal = @sumArray(equalActionIdexes)
    
    # if there are no matches
    if matchSum[actionIndex] < 1
      console.log "I don't now what you are trying to do."
    
    # if there is one obvious match
    else if equalActionsTotal is 1
      
      # get the most likey argument
      argumentSum = new Array(@allActions[actionIndex].possibleArguments.length)
      
      #result.functions.push @allActions[actionIndex].possibleFunctions[0]
      result.functions.push @allActions[actionIndex].callback

      i = 0
      while i < @allActions[actionIndex].possibleArguments.length
        argumentSum[i] = @booleanKeywordMatch(@allActions[actionIndex].possibleArguments[i], string)
        i++
      
      # get the most likey action
      argumentIndex = @getLargestIndex(argumentSum)
      console.log "argumentSum= " + argumentSum
      
      # check to see if there are any other matching cases
      equalArgumentIdexes = @equalIndexArray(argumentSum, argumentIndex)
      equalArgumentTotal = @sumArray(equalArgumentIdexes)

      console.log "YOU WANT TO"

      if equalArgumentTotal is 1
        #@allActions[actionIndex].callback @allActions[actionIndex].possibleArguments[argumentIndex]
        result.arguments.push @allActions[actionIndex].possibleArguments[argumentIndex]
      else
        @allActions[actionIndex].callback()
        console.log "but the argument is ambigous"
    
    # if there are multiple matches
    else if equalActionsTotal > 1
      console.log "It's a tie between:"
      i = 0

      while i < equalActionIdexes.length
        if equalActionIdexes[i] is 1
           @allActions[i].callback()
           result.functions.push(@allActions[i].callback())
        i++
        

    return result

  # returns the largest inex of an array
  getLargestIndex: (anArray) ->
    anArray.indexOf Math.max.apply(Math, anArray)

  # returns boolean array of 0s and 1s as to wether indexes of an other array are equal
  equalIndexArray: (arrayComparison, indexComparision) ->
    anEqualIndexArray = new Array(arrayComparison.length)
    unless arrayComparison[indexComparision] is 0
      i = 0

      while i < arrayComparison.length
        if arrayComparison[i] is arrayComparison[indexComparision]
          anEqualIndexArray[i] = 1
        else
          anEqualIndexArray[i] = 0
        i++
    anEqualIndexArray

  # returns the total number of matches of an array of keywords in a string (does not tally multiples)
  sumKeywordMatches: (keyWords, string) ->
    total = 0
    i = 0

    while i < keyWords.length
      matching = string.match(keyWords[i])
      total++  if matching? and matching.length > 0
      i++
    total

  # reuturns the sum an array (not type sensative)
  sumArray: (anArray) ->
    total = 0
    i = 0

    while i < anArray.length
      total += anArray[i]
      i++
    total

  # returns a 0 or 1 if a keyword is present in a string
  booleanKeywordMatch: (keyWord, string) ->
    total = 0
    matching = string.match(keyWord)
    total++  if matching? and matching.length > 0
    total
