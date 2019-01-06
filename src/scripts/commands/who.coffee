http = require '../networks/http'
emoji = require 'node-emoji'
chalk = require 'chalk'

print_user = (user) ->
  name = user.name or user.github_name
  github = "https://github.com/#{user.github_name}"
  console.log ''
  console.log chalk.green " #{emoji.get 'hugging_face'} #{name}"
  console.log chalk.yellow " #{emoji.get 'link'} #{github}"

fine_user = () ->
  try
    json = await http '/user', do http.make_options
    print_user json
    if not json
      fine.exit 'not found.'
  catch err
    fine.exit err


module.exports =
  run: fine_user
