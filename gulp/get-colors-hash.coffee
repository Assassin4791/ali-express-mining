gulp = require 'gulp'
q = require 'q'
gutil = require 'gulp-util'
exec = require 'exec'
fs = require 'fs'
PNG = require('pngjs').PNG
hash = require 'hash-sum'

deviceAdress = require('./config.coffee').deviceAdress
paths = require('./config.coffee').paths
screen = require('./config.coffee').device.screen

exports.getColorsHash = (coordinates, pathToScreenShot) ->
  defered = q.defer()
  fs.createReadStream pathToScreenShot
    .pipe new PNG()
    .on 'parsed', ->
      result = []
      for x in [coordinates.start.x .. coordinates.end.x]
        for y in [coordinates.start.y .. coordinates.end.y]
          idx = @.width * y + x << 2
          result.push
            r: @.data[idx]
            g: @.data[idx + 1]
            b: @.data[idx + 2] 
      defered.resolve hash result
    .on 'error', (err) ->
      defered.reject err
  defered.promise