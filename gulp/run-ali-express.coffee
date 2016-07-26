gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute
log = require('log4js').getLogger()

deviceAdress = require('./config.coffee').deviceAdress
run = "adb -s #{deviceAdress} shell monkey -p com.alibaba.aliexpresshd -c android.intent.category.LAUNCHER 1"

gulp.task 'run-ali-express',->
  log.info 'run task "run-ali-express"'
  defered = q.defer()
  exec run
    .then ->
      log.info 'done task "run-ali-express"'
      defered.resolve()
  return defered.promise