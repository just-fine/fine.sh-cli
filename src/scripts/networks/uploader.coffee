fs = require 'fs'
path = require 'path'
http = require './http'

upload = () ->
  make_absolute_path = (p) -> path.join fine.storage.cache.path, p
  
  attachments = fs.readdirSync fine.storage.cache.path, 'utf-8'
    .map (file) -> make_absolute_path file
    .filter (r) -> Boolean r
    .map (file) -> fs.createReadStream file
    
  try
    json = await http.post http.make_options
      uri: '/previews',
      formData: { attachments }
      
    if not json.repo_name
      console.log json
      fine.print.error json.message if json.message
      return fine.print.error 'upload failure.'

    url = "https://#{json.repo_name}.fine.sh/"
    fine.print.success 'created, your project is running online.'
    fine.print.success "visit link: #{url}"
  catch err
    console.log err
    process.exit 1
    
    
module.exports =
  run: upload
