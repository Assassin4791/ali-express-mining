gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress

stop = "adb -s #{deviceAdress} shell am force-stop com.alibaba.aliexpresshd"

gulp.task 'stop-ali-express',->
  defered = q.defer()
  exec stop
    .then -> defered.resolve()
  return defered.promise