inquirer = require 'inquirer'
emoji = require 'node-emoji'
chalk = require 'chalk'
path = require 'path'
fs = require 'fs'
template = require './template'
guider = require './guider'

isDirectory = (dir_name) ->
  return false if not fs.existsSync dir_name
  stat = fs.statSync (path.join process.cwd(), dir_name)
  Boolean do stat.isDirectory

fine_name_from_package = () ->
  package_path = path.join do process.cwd, 'package.json'
  return null if not fs.existsSync package_path
  json = {}
  try
    json = JSON.parse fs.readFileSync package_path, 'utf-8'
  catch
    json = {}
  (json.name and json.name) or null

promps = [
  {
    type: 'input'
    name: 'project_name'
    message: 'project name:'
    default: do fine_name_from_package
    validate: (txt) ->
      pass = fine.project_reg.test txt
      if not pass
        console.log chalk.yellow "\n#{emoji.get 'white_frowning_face'} this name can't be used.\n"
      pass
  }
  {
    type: 'input'
    name: 'document_folder'
    message: 'Which folder do you need to publish (enter c to exit):'
    default: './'
    validate: (txt) ->
      if txt.toLowerCase() is 'c'
        console.log chalk.yellow "\n#{emoji.get 'wave'} it's cancelled. nothing happened."
        process.exit 1
      if not isDirectory txt
        console.log chalk.yellow "\n#{emoji.get 'white_frowning_face'} this is not a folder.\n"
        return false
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
    console.log chalk.red " #{emoji.get 'x'}  there are problems in the setting file."
    console.log chalk.cyan " #{emoji.get 'thinking_face'} you need to check [#{chalk.yellow '.fine/fine.json'}] agian."
    process.exit 1

create_setting_file = (setting) ->
  paths = path.join process.cwd(), '.fine'
  full_setting = Object.assign {}, template, setting
  fs.mkdirSync paths if not fs.existsSync paths
  fs.writeFileSync (path.join paths, 'fine.json'), JSON.stringify full_setting, '', '\t'
  
  console.log ''
  console.log chalk.green " #{emoji.get 'coffee'} setting file (.fine/fine.json) created.\n"
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
    fine.exit err

module.exports =
  run: initiator
