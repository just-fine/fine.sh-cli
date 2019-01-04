###
  generate interface configurations for @fine/runtime.
  these configurations will be inserted into Window scope when the browser parses.
###
path = require 'path'

# visitors do not have any settings.
# set the first document to the "home page".
tourist_passage = (sides) ->
  sides[0].index = true
  sides

sides_assign_settings = (sides, settings) ->
  return tourist_passage sides if fine.is_tourist?
  # todo
  tourist_passage sides

make_catalog = (hashes) ->
  translate_api = ({ name, hash }) -> { label: name, url: "#{name}.#{hash}.html" }
  translate_api item for item in hashes
  
runtime = (hashes, settings) ->
  sides = make_catalog hashes
  custom_sides = sides_assign_settings sides, settings
  {
    sides: custom_sides
  }

module.exports =
  run: runtime
