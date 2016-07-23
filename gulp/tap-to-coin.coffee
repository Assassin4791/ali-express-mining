gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress
coordinates = require('./config.coffee').coordinates

tapToBonusPage = "adb -s #{deviceAdress} shell input tap #{coordinates.coin.x} #{coordinates.coin.y}"

gulp.task 'tap-to-coin',->
  defered = q.defer()
  exec tapToBonusPage
    .then -> defered.resolve()
  return defered.promise