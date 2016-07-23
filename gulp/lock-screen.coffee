gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress
coordinates = require('./config.coffee').coordinates.unlockScreen
adb = require('./config.coffee').adb

unlockScreen = "adb -s #{deviceAdress} shell input keyevent #{adb.shell.input.keyevents.unlockScreen}"

gulp.task 'lock-screen',->
  defered = q.defer()
  exec unlockScreen
    .then -> defered.resolve()
  return defered.promise
