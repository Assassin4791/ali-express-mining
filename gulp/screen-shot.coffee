gulp = require 'gulp'
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress

exports.screenShot = (path) ->
  exec "adb -s #{deviceAdress} shell screencap -p | perl -pe 's/\\x0D\\x0A/\\x0A/g' > #{path}"
