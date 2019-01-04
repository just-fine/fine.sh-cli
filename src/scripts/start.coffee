settings = require './settings'
builds = require './builds'

start = () ->
  user_settings = await settings.safe_get
  processor = (fine.is_tourist and builds.tourist) or builds.leaguer
  
  processor user_settings
  
  
  

do start
#source =


