http = require '../networks/http'
inquirer = require 'inquirer'
emoji = require 'node-emoji'
chalk = require 'chalk'

make_choices = (projects) ->
  projects.map (item) ->
    name: item.repo_name
    value: item.repo_name

find_projects = () ->
  try
    json = await http '/projects', do http.make_options
    if not json or not json.projects or json.projects.length is 0
      console.log chalk.yellow "#{emoji.get 'anguished'} not found projects."
      process.exit 1
    json.projects
  catch err
    fine.exit err

remove_project_by_name = (name) ->
  try
    await http.delete "/projects/#{name}", do http.make_options
    console.log ''
    console.log chalk.cyan "#{emoji.get 'ok_hand'} #{name} has been removed."
    process.exit 1
  catch err
    fine.exit err

remove_project = () ->
  projects = await do find_projects
  choices = make_choices projects
  promps = [{
    choices,
    type: 'list'
    name: 'project_name'
    message: 'Which project do you want to remove?'
  }, {
    type: 'input'
    name: 'confirm'
    message: 'Do you really want to delete project? (Y/N)'
    validate: (txt) -> txt.toLowerCase() is 'n' or txt.toLowerCase() is 'y'
  }]
  
  { project_name, confirm } = await inquirer.prompt promps
  if confirm.toLowerCase() is 'n'
    console.log ''
    console.log chalk.yellow "#{emoji.get 'wave'} it's cancelled. nothing happened."
    process.exit 1
  await remove_project_by_name project_name
  
  console.log project_name, confirm

module.exports =
  run: remove_project
