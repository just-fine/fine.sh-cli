emoji = require 'node-emoji'
chalk = require 'chalk'
path = require 'path'
ora = require 'ora'
fs = require 'fs'
http = require './http'
wait = new ora

count = (len) ->
  (len <= 0 and 1) or len - 1
  
project_name_check = (settings) ->
  json
  try
    json = await http "/projects/#{settings.project_name}/repo_name", do http.make_options
  catch err
    fine.exit err
  return true if json and json.pass is true
  console.log ''
  console.log chalk.yellow " #{emoji.get 'joy_cat'} project_name is already taken."
  console.log chalk.cyan " #{emoji.get 'point_right'} try to modify project name in [#{chalk.yellow '[fine.json]'}]"
  process.exit 1


upload = (settings) ->
  upload_url = (fine.is_tourist and '/previews') or "/projects/#{settings.project_name}/files"

  if not fine.is_tourist
    await project_name_check settings
    
  make_absolute_path = (p) -> path.join fine.storage.cache.path, p
  attachments = fs.readdirSync fine.storage.cache.path, 'utf-8'
    .map (file) -> make_absolute_path file
    .filter (r) -> Boolean r
    .map (file) -> fs.createReadStream file
  
  wait.start "#{count attachments.length} files awaiting processing..."
  try
    json = await http.post http.make_options
      uri: upload_url,
      formData: { attachments }
      
    if not json.repo_name
      fine.print.error json.message if json.message
      return wait.fail 'upload failure.'

    url = "https://#{json.repo_name}.fine.sh/"
    
    do wait.clear
    console.log chalk.white " #{emoji.get 'rocket'} uploaded #{count attachments.length} files.\n"
    console.log chalk.cyan " #{emoji.get '+1'} great! your project is running online now."
    console.log chalk.cyan " #{emoji.get 'link'} visit link: #{chalk.yellow.underline url}"
    process.exit 1
  catch err
    fine.exit err
    
    
module.exports =
  run: upload
