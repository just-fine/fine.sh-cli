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
    (next = next.concat collect join child) for child in fs.readdirSync paths, 'utf-8'
    return next.filter (r) -> r?
  
  files = collect catalog
  fine.exit 'no documents were found.' if not files or files.length is 0
  fine.exit 'too many files. documents cannot exceed 100.' if files.length > 100
  files


module.exports =
  run: collect_paths_of_file
