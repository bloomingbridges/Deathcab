{exec} = require "child_process"

sourceFiles = "src/main.coffee"

task "watch", "Build project from src/*.coffee to lib/*.js", ->
  exec " coffee -w -j deathcab.js -c -o lib/ " + sourceFiles, (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr