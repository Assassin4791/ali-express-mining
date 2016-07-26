gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute
log = require('log4js').getLogger()

deviceAdress = require('./config.coffee').deviceAdress
coordinates = require('./config.coffee').coordinates
wait = require('./wait-state.coffee').wait

tapToBonusPage = "adb -s #{deviceAdress} shell input tap #{coordinates.bonuxPage.x} #{coordinates.bonuxPage.y}"

gulp.task 'run-bonus-page', ->
  log.info 'run task "run-bonus-page"'
  defered = q.defer()
  wait.main()
    .then -> exec tapToBonusPage
    .then -> wait.bonus()
    .then -> wait.loadUserData()
    .then ->
      log.info 'done task "run-bonus-page"'
      defered.resolve()
    .catch (err) ->
      log.error "task 'run-bonus-page' fail, err = \n\n#{err}"
      defered.reject()
  return defered.promise