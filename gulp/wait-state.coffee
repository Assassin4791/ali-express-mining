gulp = require 'gulp'
q = require 'q'
_ = require 'underscore'
log = require('log4js').getLogger()
screenShot = require('./screen-shot.coffee').screenShot
getColorsHash = require('./get-colors-hash.coffee').getColorsHash

waitScreenShot = require('./config.coffee').paths.waitScreenShot
states = require('./config.coffee').states

waitState = (state, path, name, condition) ->
  #defered = q.defer()
  log.debug "start wait state #{name}"
  exit = false
  timerId = setTimeout (->
    exit = true), 15000

  checkState = (state, path) ->
    log.debug "check state #{state}, #{path}"
    if exit
      log.error "done wait state #{name}, fail"
      return q.reject "timeout"
    screenShot path
      .then ->
        getColorsHash state.coordinates, path
          .then (hash) ->
            if condition hash, state.hash
              clearTimeout timerId
              log.debug "done wait state #{name}, sucsess"
              return q.when()
            checkState state, path
  checkState state, path

wait = {}

_.each states, (value, key) ->
  wait[key] = -> waitState value, waitScreenShot, key,(a, b) ->
    result = a == b
    log.debug "#{a} == #{b} is #{result}"
    result
  a = key.substring 0, 1
  b = key.substring 1, key.length
  negative = "not#{a.toUpperCase()}#{b}"
  wait[negative] = -> waitState value, waitScreenShot, negative, (a, b) ->
    result = a != b
    log.debug "#{a} != #{b} is #{result}"
    result

wait.loadUserData = ->
  defered = q.defer()
  log.debug "start wait load user data"
  setTimeout defered.resolve, 15000
  log.debug 'done wait load user data'
  defered.promise

exports.wait = wait