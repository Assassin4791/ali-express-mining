gulp = require 'gulp'
q = require('q')
mkdirp = require 'mkdirp'
gutil = require 'gulp-util'
rm = require 'rimraf'

path = require('./config.coffee').paths.temp

gulp.task 'create-dirs', ->
  defered = q.defer()
  rm.sync path
  mkdirp path, (err) ->
    if err
      gutil.log gutil.colors.red err
      defered.reject()
      return
    gutil.log 'create dir done!'
    defered.resolve()
  defered.promise