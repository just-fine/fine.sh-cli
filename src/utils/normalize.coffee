pkg = require '../../package.json'
storage = require './storage'
print = require './print'
emoji = require 'node-emoji'
rimraf = require 'rimraf'
chalk = require 'chalk'

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
  
  project_reg: /^[a-z][a-z0-9\-]{4,20}[a-z]$/
  
  exit: (txt) ->
    console.log chalk.red "#{emoji.get 'astonished'} something looks wrong."
    console.log chalk.red txt if txt
    process.exit 1

  rm: (paths) ->
    new Promise (resolve, reject) ->
      rimraf paths, (err) ->
        reject err if err?
        do resolve
  
  
