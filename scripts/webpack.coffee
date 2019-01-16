fs = require 'fs'
path = require 'path'
webpack = require 'webpack'
pkg = require '../package.json'
dir = path.resolve __dirname, '../src/bin'

[entry, ext] = [{}, {}]
entry = Object.assign(entry, { "bin/#{file.split('.coffee')[0]}": "#{dir}/#{file}" }) for \
  file in fs.readdirSync dir, 'utf-8'

ext = Object.assign(ext, { "#{name}": "require('#{name}')" }) for name of pkg.dependencies

module.exports = ->
  entry: entry

  output:
    path: path.resolve __dirname, '../dist'
    filename: '[name].js'

  externals: ext

  resolve:
    extensions: ['.coffee']

  node:
    __dirname: false
    __filename: true

  target: 'node'
  
  module:
    rules: [
      test: /\.coffee$/
      exclude: /node_modules/
      use: [{
        loader: 'coffee-loader'
        options:
          sourceMap: true
      }]
    ]

  plugins: [
    new webpack.BannerPlugin
      raw: true
      banner: '#!/usr/bin/env node'
      exclude: 'index.js'
  ]


