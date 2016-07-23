gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress
coordinates = require('./config.coffee').coordinates
wait = require('./wait-state.coffee').wait

tapToBonusPage = "adb -s #{deviceAdress} shell input tap #{coordinates.bonuxPage.x} #{coordinates.bonuxPage.y}"

gulp.task 'run-bonus-page',->
  defered = q.defer()
  wait.main()
    .then -> exec tapToBonusPage
    .then -> wait.bonus()
    .then -> wait.loadUserData()
    .then -> defered.resolve()
  return defered.promise