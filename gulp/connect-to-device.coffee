gulp = require 'gulp'
q = require 'q'
log = require('log4js').getLogger()
exec = require('./execute.coffee').execute

deviceAdress = require('./config.coffee').deviceAdress

gulp.task 'connect-to-device', ->
  log.info "connect to device #{deviceAdress}"
  defered = q.defer()
  exec "adb connect #{deviceAdress}"
    .then (out) ->
      result = defered.reject
      if out.search(/(connected to |already connected to )/) > -1
        log.info "done connect to device #{deviceAdress}"
        result = defered.resolve
      else
        log.error "Not found rows on success, out = #{out}"
      result()
    .catch (err) ->
      log.error "error in connection to device, error = #{err}"
      defered.reject()
      throw err
  return defered.promise