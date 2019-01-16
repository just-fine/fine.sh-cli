merge = require 'webpack-merge'
base = require './webpack'


module.exports = merge do base,
  mode: 'production'

  devtool: 'eval'
