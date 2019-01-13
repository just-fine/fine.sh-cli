inquirer = require 'inquirer'

choices = [{
  name: 'No, build now!'
  value: true
}, {
  name: 'OK, generate a setting file in project.'
  value: false
}]

promps = [{
  choices,
  type: 'list'
  name: 'is_tourist'
  message: 'Do you need to create a configuration file？\n  (preview site has 1 hour limit)\n'
}]

guider = () ->
  { is_tourist } = await inquirer.prompt promps
  fine.is_tourist = is_tourist
  is_tourist

module.exports =
  run: guider
