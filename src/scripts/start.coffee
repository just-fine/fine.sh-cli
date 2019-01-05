commander = require 'commander'
settings = require './settings'
builds = require './builds'
apis = require './networks'

arg = commander.args[0]

login = () ->
  await do apis.login

start = () ->
  user_settings = await settings.safe_get
  processor = (fine.is_tourist and builds.tourist) or builds.leaguer

  await processor user_settings
  await apis.upload user_settings

if arg is 'login'
  do login
else
  do start

