merge = require 'webpack-merge'
base = require './webpack'


module.exports = merge do base,
  mode: 'development'

  devtool: 'cheap-module-eval-source-map'
