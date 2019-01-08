emoji = require 'node-emoji'
chalk = require 'chalk'
path = require 'path'
fs = require 'fs'
current_dir = process.cwd()

ignores = [
  /node_modules/, /\.git/, /\.idea/
]

is_ignore = (paths) -> Boolean ignores.find ((reg) -> reg.test paths)
  
is_markdown = (paths) -> Boolean /\.md$/.test paths

is_directory = (paths) -> Boolean (fs.statSync paths).isDirectory()

# collect file and return
# { path: string, name: string, category?: string }
collect_paths_of_file = (catalog) ->
  make_node = (paths) ->
    { name, dir } =  path.parse paths
    category = (dir.split path.sep).pop()
    category = null if dir is current_dir
    { path: paths, name, category }
  
  collect = (paths) ->
    return [make_node paths] if is_markdown paths
    return [null] if (is_ignore paths) or not is_directory paths
    next = []
    join = (name) -> path.join paths, name
    (next = next.concat collect join child) for child in fs.readdirSync paths, 'utf-8'
    return next.filter (r) -> r and r.name
  
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
