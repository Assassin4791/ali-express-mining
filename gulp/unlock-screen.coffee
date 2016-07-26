gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute
log = require('log4js').getLogger()

deviceAdress = require('./config.coffee').deviceAdress
coordinates = require('./config.coffee').coordinates.unlockScreen
adb = require('./config.coffee').adb

unlockScreen = "adb -s #{deviceAdress} shell input keyevent #{adb.shell.input.keyevents.unlockScreen}"
tap1 = "adb -s #{deviceAdress} shell input tap #{coordinates[1].x} #{coordinates[1].y}"
tap2 = "adb -s #{deviceAdress} shell input tap #{coordinates[2].x} #{coordinates[2].y}"
tap3 = "adb -s #{deviceAdress} shell input tap #{coordinates[3].x} #{coordinates[3].y}"
tap4 = "adb -s #{deviceAdress} shell input tap #{coordinates[4].x} #{coordinates[4].y}"
tap5 = "adb -s #{deviceAdress} shell input tap #{coordinates[5].x} #{coordinates[5].y}"

gulp.task 'unlock-screen', ->
  log.info 'run task "unlock-screen"'
  defered = q.defer()
  exec unlockScreen
    .then -> exec tap1
    .then -> exec tap2
    .then -> exec tap3
    .then -> exec tap4
    .then -> exec tap5
    .then ->
      log.info 'done task "unlock-screen"'
      defered.resolve()
  return defered.promise
