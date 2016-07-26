gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute
log = require('log4js').getLogger()

deviceAdress = require('./config.coffee').deviceAdress

stop = "adb -s #{deviceAdress} shell am force-stop com.alibaba.aliexpresshd"

gulp.task 'stop-ali-express', ->
  log.info 'run task "stop-ali-express"'
  defered = q.defer()
  exec stop
    .then ->
      log.info 'done task "stop-ali-express"'
      defered.resolve()
  return defered.promise