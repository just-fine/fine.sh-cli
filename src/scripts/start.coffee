settings = require './settings'
builds = require './builds'
apis = require './networks'
commands = require './commands'


start = () ->
  user_settings = await settings.safe_get
  processor = (fine.is_tourist and builds.tourist) or builds.leaguer

  await processor user_settings
  await apis.upload user_settings

do ->
  has_command = await do commands.run
  do start if not has_command
