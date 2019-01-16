{ execSync } = require 'child_process'
fs = require 'fs'
path = require 'path'
webpack = require 'webpack'
dev_configs = require './scripts/webpack.dev'
prod_config = require './scripts/webpack.prod'

err_handle = (stats) ->
  console.error stats?.error
  console.error stats.details if stats.details is yes
  process.exit 1

log_handle = (stats) ->
  console.log stats.toString
    colors: true


task 'start', 'lift a dev server', ->
  webpack dev_configs
    .watch { ignored: /node_modules/ }, (err, stats) ->
      err_handle stats if err?
      log_handle stats


task 'build', 'build bundle', ->
  execSync 'rm -rf ./dist'
  webpack prod_config, (err, stats) ->
    err_handle stats if err?
    log_handle stats


task 'clear', 'clear all', ->
 execSync 'rm -rf dist temp .nyc_output coverage'
