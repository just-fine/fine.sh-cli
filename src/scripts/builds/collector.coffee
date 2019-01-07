emoji = require 'node-emoji'
chalk = require 'chalk'
path = require 'path'
fs = require 'fs'

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
  if not files or files.length is 0
    console.log ''
    console.log chalk.yellow " #{emoji.get 'whale'} no documents (.md) were found."
    console.log chalk.cyan " #{emoji.get 'point_right'} try create a document called \"hello.md\"? "
    process.exit 1

  if files.length > 100
    console.log ''
    console.log chalk.yellow " #{emoji.get 'thinking_face'} too many files. documents cannot exceed 100."
    process.exit 1

  files


module.exports =
  run: collect_paths_of_file
