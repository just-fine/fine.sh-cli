initiator = require './initiator'

class Settings
  @_setting = {}
  @test = 'ok'
  
  @check_setting_file: () ->
    return await do initiator.run if not @_setting.project_name
    Promise.resolve @_setting
  
  @define 'safe_get',
    get: ->
      @_setting = await @check_setting_file()
      @_setting


module.exports = new Settings

