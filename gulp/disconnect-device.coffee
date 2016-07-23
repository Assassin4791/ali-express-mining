gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress

disconnect = "adb disconnect #{deviceAdress}"
killServer = "adb kill-server"

gulp.task 'disconnect-device',->
  defered = q.defer()
  exec disconnect
    .then -> exec killServer
    .then -> defered.resolve()
  return defered.promise
