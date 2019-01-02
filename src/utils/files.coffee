fs = require 'fs'
path = require 'path'

collect_file = (catalog) ->
  files = fs.readdirSync catalog
  collect = (f) ->
    child = path.join catalog, f
    stat = fs.statSync child
    return collect_file chiild if do stat.isFile
    return child if do stat.isDirectory
    null
  
  paths = (collect file for file in files)
  paths

