q = require 'q'
exec = require 'exec'

exports.execute = (command) ->
  defered = q.defer()
  exec command, (err, out, code) ->
    if (err instanceof Error)
      gutil.log gutil.colors.red err
      defered.reject err
      throw err
    defered.resolve out
  return defered.promise

