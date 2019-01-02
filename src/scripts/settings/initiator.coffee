fs = require 'fs'
path = require 'path'
inquirer = require 'inquirer'
template = require './template'
guider = require './guider'

isDirectory = (dir_name) ->
  return false if not fs.existsSync dir_name
  stat = fs.statSync (path.join process.cwd(), dir_name)
  Boolean do stat.isDirectory

promps = [
  {
    type: 'input'
    name: 'project_name'
    message: 'Enter your project name:'
    validate: (txt) -> txt?
  }
  {
    type: 'input'
    name: 'target'
    message: 'Which folder do you need to publish (enter c to exit):'
    validate: (txt) ->
      process.exit 1 if txt is 'c'
      return console.log '\nthis is not a folder.' if not isDirectory txt
      true
  }
]

find_setting_file = () ->
  paths = path.join process.cwd(), '.fine/fine.json'
  isExist = fs.existsSync paths
  return false if not isExist
  setting = fs.readFileSync paths, 'utf-8'
  try
    return JSON.parse setting
  catch err
    console.log 'configuration file has some problems. check ".fine/fine.json" agian.'
    process.exit 1

create_setting_file = (setting) ->
  paths = path.join process.cwd(), '.fine'
  full_setting = Object.assign {}, template, setting
  fs.mkdirSync paths if not fs.existsSync paths
  fs.writeFileSync (path.join paths, 'fine.json'), JSON.stringify full_setting
  console.log 'setting file (.fine/fine.json) created. \n'
  full_setting

# return a setting file
# create a new setting file if not found
# do nothing if user select tourist (preview publish)
initiator = () ->
  setting = do find_setting_file
  return setting if setting
  
  is_tourist = await do guider.run
  return template if is_tourist
  
  try
    answer = await inquirer.prompt promps
    return create_setting_file answer
  catch err
    console.log err
    process.exit 1

module.exports =
  run: initiator
