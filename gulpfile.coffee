gulp = require 'gulp'
runSequence = require('run-sequence').use gulp

require './gulp/clean.coffee'
require './gulp/create-dirs.coffee'
require './gulp/connect-to-device.coffee'
require './gulp/screen-shot.coffee'
require './gulp/unlock-screen.coffee'
require './gulp/lock-screen.coffee'
require './gulp/run-ali-express.coffee'
require './gulp/stop-ali-express.coffee'
require './gulp/run-bonus-page.coffee'
require './gulp/tap-to-coin.coffee'
require './gulp/disconnect-device.coffee'


exec = require('./gulp/execute.coffee').execute

gulp.task 'devices-test', ->
  exec 'adb devices'

gulp.task 'default', (cb) ->
  runSequence 'clean',
    'disconnect-device'
    'create-dirs'
    'connect-to-device'
    'devices-test'
    'unlock-screen'
    'stop-ali-express'
    'run-ali-express'
    'run-bonus-page'
    'tap-to-coin'
    'stop-ali-express'
    'lock-screen'
    'disconnect-device'
    cb