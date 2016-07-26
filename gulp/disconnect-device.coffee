gulp = require 'gulp'
q = require 'q'
log = require('log4js').getLogger()
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress

disconnect = "adb disconnect #{deviceAdress}"
killServer = "adb kill-server"

gulp.task 'disconnect-device',->
  log.info 'start task "disconnect-device"'
  defered = q.defer()
  exec disconnect
    .then -> exec killServer
    .then ->
      log.info 'done task "disconnect-device"'
      defered.resolve()
  return defered.promise
