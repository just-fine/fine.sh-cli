require '../../src/scripts/settings/guider'
{ expect } = require 'chai'
coffee = require '../coffee_custom'
path = require 'path'
guider_path = path.join __dirname, '../../src/scripts/settings/guider'

describe 'settings guider test', () ->
  it 'should exit success and set tourist in global', () ->
    set_tourist_to_true = (val) ->
      expect val
        .to.be.an 'object'
        .to.contains.keys 'is_tourist'
        .to.include { is_tourist: true }

    coffee.run guider_path
      .writeKey 'ENTER'
      .expect 'return', true
      .expect 'global', set_tourist_to_true
      .expect 'code', 0
      .end()

  it 'should exit success and set tourist to false', () ->
    set_tourist_to_false = (val) ->
      expect val
        .to.be.an 'object'
        .to.contains.keys 'is_tourist'
        .to.include { is_tourist: false }

    coffee.run guider_path
      .writeKey 'DOWN'
      .writeKey 'ENTER'
      .expect 'return', false
      .expect 'global', set_tourist_to_false
      .expect 'code', 0
      .end()

