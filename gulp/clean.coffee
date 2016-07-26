gulp = require 'gulp'
clean = require 'gulp-clean'
log = require('log4js').getLogger()

path = require('./config.coffee').paths.temp

gulp.task 'clean', ->
  log.info 'run task "clean"'
  return gulp.src path, read: false
    .pipe clean()