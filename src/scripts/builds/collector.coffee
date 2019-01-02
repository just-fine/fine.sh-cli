fs = require 'fs'
path = require 'path'

ignores = [
  /node_modules/, /\.git/, /\.idea/
]

is_ignore = (paths) -> Boolean ignores.find ((reg) -> reg.test paths)
  
is_markdown = (paths) -> Boolean /\.md$/.test paths

is_directory = (paths) -> Boolean (fs.statSync paths).isDirectory()


collect_paths_of_file = (catalog) ->
  collect = (paths) ->
    return [paths] if is_markdown paths
    return [null] if (is_ignore paths) or not is_directory paths
    next = []
    join = (name) -> path.join paths, name
    (next = next.concat collect join child) for child in fs.readdirSync paths
    return next.filter (r) -> r?
  
  collect catalog




module.exports =
  run: collect_paths_of_file

