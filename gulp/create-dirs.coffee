gulp = require 'gulp'
q = require('q')
mkdirp = require 'mkdirp'
log = require('log4js').getLogger()
rm = require 'rimraf'

path = require('./config.coffee').paths.temp

gulp.task 'create-dirs', ->
  log.info 'start task "create-dirs"'
  defered = q.defer()
  rm.sync path
  mkdirp path, (err) ->
    if err
      log.error "cannot create dirs, err = #{err}"
      defered.reject()
      return
    log.info 'task "create-dirs" done'
    defered.resolve()
  defered.promise