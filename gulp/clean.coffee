gulp = require 'gulp'
clean = require 'gulp-clean'

path = require('./config.coffee').paths.temp

gulp.task 'clean', ->
  console.warn 'path', path
  return gulp.src path, read: false
    .pipe clean()