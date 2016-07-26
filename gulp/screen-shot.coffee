gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute
log = require('log4js').getLogger()

deviceAdress = require('./config.coffee').deviceAdress

exports.screenShot = (path) ->
  defered = q.defer()
  log.debug "set screenshot, path = #{path}"
  exec "adb -s #{deviceAdress} shell screencap -p | perl -pe 's/\\x0D\\x0A/\\x0A/g' > #{path}"
    .then ->
      log.debug "sucsess screenshot, path = #{path}"
      defered.resolve()
    .catch ->
      log.debug "fail screenshot, path = #{path}"
      defered.reject()
  defered.promise

