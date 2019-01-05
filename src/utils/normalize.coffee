pkg = require '../../package.json'
storage = require './storage'
print = require './print'

Function::define = (prop, desc) ->
  actions = {}
  bind_value = (val) -> (typeof val is 'function' and val.bind @) or val
  actions[key] = bind_value.call @, desc[key] for key of desc when key?
  Object.defineProperty this.prototype, prop, actions


global.fine =
  version: pkg.version
  
  is_tourist: false

  storage: storage

  print: print
  
  
  
