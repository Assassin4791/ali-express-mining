q = require 'q'
exec = require 'exec'
log = require('log4js').getLogger()

exports.execute = (command) ->
  defered = q.defer()
  log.debug "start execute command '#{command}'"
  exec command, (err, out, code) ->
    if (err instanceof Error)
      log.error "error in execute command '#{command}', err = \n\n#{err}"
      defered.reject err
      throw err
    log.debug "done execute command '#{command}'"
    log.debug "out put '#{command}' = \n\n#{out}"
    defered.resolve out
  return defered.promise

