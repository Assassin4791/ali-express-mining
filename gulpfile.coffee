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


paths = require('./gulp/config.coffee').paths

gulp.task 'default', (cb) ->
  runSequence 'clean',
    ['create-dirs', 'connect-to-device']
    'stop-ali-express'
    ['unlock-screen', 'run-ali-express']
    'run-bonus-page'
    'tap-to-coin'
    'stop-ali-express'
    'lock-screen'
    'disconnect-device'
    cb