gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute
log = require('log4js').getLogger()

deviceAdress = require('./config.coffee').deviceAdress
coordinates = require('./config.coffee').coordinates.unlockScreen
adb = require('./config.coffee').adb

unlockScreen = "adb -s #{deviceAdress} shell input keyevent #{adb.shell.input.keyevents.unlockScreen}"

gulp.task 'lock-screen',->
  log.info 'run task "clean"'
  defered = q.defer()
  exec unlockScreen
    .then ->
      log.info 'done task "clean"'
      defered.resolve()
  return defered.promise
