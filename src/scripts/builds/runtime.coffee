###
  generate interface configurations for @fine/runtime.
  these configurations will be inserted into Window scope when the browser parses.
###
path = require 'path'

# visitors do not have any settings.
set_default_index = (sides) ->
  sides[0].index = true
  sides

sides_assign_settings = (sides, settings) ->
  return set_default_index sides if fine.is_tourist
  
  has_index = false
  set_index = (item) ->
    return item if item.label isnt settings.index_page
    has_index = true
    item.index = true

  sides = (set_index item for item in sides)
  (has_index and sides) or set_default_index sides

make_catalog = (hashes) ->
  translate_api = ({ name, hash }) -> { label: name, url: "#{name}.#{hash}.html" }
  translate_api item for item in hashes

make_project_name = (settings) ->
  return null if fine.is_tourist
  settings.project_name

runtime = (hashes, settings) ->
  sides = make_catalog hashes
  custom_sides = sides_assign_settings sides, settings
  
  {
    sides: custom_sides
    project_name: make_project_name settings
  }


module.exports =
  run: runtime
