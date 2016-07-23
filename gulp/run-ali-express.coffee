gulp = require 'gulp'
q = require 'q'
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress
run = "adb -s #{deviceAdress} shell monkey -p com.alibaba.aliexpresshd -c android.intent.category.LAUNCHER 1"

gulp.task 'run-ali-express',->
  defered = q.defer()
  exec run
    .then -> defered.resolve()
  return defered.promise