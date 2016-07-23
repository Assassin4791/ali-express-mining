gulp = require 'gulp'
q = require 'q'
_ = require 'underscore'
screenShot = require('./screen-shot.coffee').screenShot
getColorsHash = require('./get-colors-hash.coffee').getColorsHash

waitScreenShot = require('./config.coffee').paths.waitScreenShot
states = require('./config.coffee').states

waitState = (state, path, name, condition) ->
  defered = q.defer()
  console.warn "start wate state #{name}"
  timerId = setTimeout q.reject, 15000

  checkState = (state, path) ->
    screenShot path
      .then ->
        getColorsHash state.coordinates, path
          .then (hash) ->
            console.warn hash, state.hash
            if condition hash, state.hash
              clearTimeout timerId
              return defered.resolve()
            checkState state, path
  checkState state, path
  defered.promise

wait = {}

_.each states, (value, key) ->
  wait[key] = -> waitState value, waitScreenShot, key,(a, b) -> a == b
  a = key.substring 0, 1
  b = key.substring 1, key.length
  negative = "not#{a.toUpperCase()}#{b}"
  wait[negative] = -> waitState value, waitScreenShot, negative, (a, b) -> a != b

wait.loadUserData = ->
  defered = q.defer()
  setTimeout defered.resolve, 15000
  defered.promise 

exports.wait = wait