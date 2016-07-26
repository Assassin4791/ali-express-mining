gulp = require 'gulp'
q = require 'q'
fs = require 'fs'
PNG = require('pngjs').PNG
hash = require 'hash-sum'
log = require('log4js').getLogger()

deviceAdress = require('./config.coffee').deviceAdress
paths = require('./config.coffee').paths
screen = require('./config.coffee').device.screen

exports.getColorsHash = (coordinates, pathToScreenShot) ->
  log.debug "start get color hash"
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
      resultHash = hash result
      log.debug "done get color hash = #{resultHash}"
      defered.resolve resultHash
    .on 'error', (err) ->
      log.error "error get color hash, err = \n\n#{err}"
      defered.reject err
  defered.promise