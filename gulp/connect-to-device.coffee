gulp = require 'gulp'
q = require 'q'
gutil = require 'gulp-util'
exec = require 'exec'

deviceAdress = require('./config.coffee').deviceAdress

gulp.task 'connect-to-device', ->
  defered = q.defer()
  exec "adb connect #{deviceAdress}", (err, out, code) ->
    if (err instanceof Error)
      gutil.log gutil.colors.red err
      defered.reject()
      throw err
    result = defered.reject
    if out.search(/(connected to |already connected to )/) > -1
      result = defered.resolve
    else
      gutil.log gutil.colors.red out
    
    result()
  return defered.promise