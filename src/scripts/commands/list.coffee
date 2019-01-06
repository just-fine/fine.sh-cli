Table = require 'cli-table3'
chalk = require 'chalk'
ora = require 'ora'
http = require '../networks/http'
wait = new ora

print_list = (projects) ->
  make_link = (name) -> "https://#{name}.fine.sh/"
  wait.succeed "you have #{projects.length} projects:"
  table = new Table
    head: (chalk.green s for s in [' index', 'project name', 'link', 'created at'])
    
  table.push [
    { content: index + 1, hAlign: 'center' }
    { content: item.repo_name }
    { content: chalk.yellow.underline make_link item.repo_name, hAlign: 'center' }
    { content: chalk.gray (new Date item.created_at).toLocaleString() }
  ] for item, index in projects
  console.log "#{table}"

fine_list = () ->
  wait.start 'refresh projects...'
  try
    json = await http '/projects', do http.make_options
    if not json or not json.projects
      wait.fail 'not found projects.'
      process.exit 1
    
    print_list json.projects
  catch err
    fine.exit err
    

module.exports =
  run: fine_list
