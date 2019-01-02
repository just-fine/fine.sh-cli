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

tourist_check = () ->
  try
    { is_tourist } = await inquirer.prompt promps
    fine.is_tourist = is_tourist
    is_tourist
  catch err
    console.log err
    process 1

module.exports = tourist_check
