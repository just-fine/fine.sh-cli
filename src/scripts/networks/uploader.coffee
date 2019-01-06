fs = require 'fs'
path = require 'path'
ora = require 'ora'
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
  fine.print.error 'project_name is already taken.'
  process.exit 1


upload = (settings) ->
  upload_url = (fine.is_tourist and '/previews') or "/projects/#{settings.project_name}/files"

  if fine.is_tourist
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
    wait.succeed "uploaded #{count attachments.length} files."
    fine.print.success 'created, your project is running online.'
    fine.print.success "visit link: #{url}"
  catch err
    console.log err
    process.exit 1
    
    
module.exports =
  run: upload
