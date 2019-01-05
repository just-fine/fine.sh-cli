settings = require './settings'
builds = require './builds'
apis = require './networks'

start = () ->
  user_settings = await settings.safe_get
  processor = (fine.is_tourist and builds.tourist) or builds.leaguer
  
  await processor user_settings
  await do apis.upload

do start

