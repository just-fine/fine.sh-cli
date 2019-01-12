###
  generate interface configurations for @fine/runtime.
  these configurations will be inserted into Window scope when the browser parses.
###
path = require 'path'
sortor = require './sortor'

# visitors do not have any settings.
set_default_index = (sides) ->
  sides[0].index = true
  sides

sides_assign_settings = (sides, settings) ->
  return set_default_index sides if fine.is_tourist
  if "#{settings.index_page}".includes '.md'
    settings.index_page = (settings.index_page.split '.md')[0]

  has_index = false
  set_index = (item) ->
    return item if item.label isnt settings.index_page
    has_index = true
    Object.assign item, { index: true }

  sides = (set_index item for item in sides)
  (has_index and sides) or set_default_index sides

sides_assign_category = (sides) ->
  remove_duplicate = (children) ->
    keys = {}
    children.filter (r) ->
      return false if keys[r.label]
      keys[r.label] = true
      return true

  next = sides.filter (item) -> not item.category
  categories = {}
  for item in sides
    if item.category
      categories[item.category] ?= []
      categories[item.category].push { url: item.url, label: item.label }
  next.push { label: key, children: remove_duplicate item }  for key, item of categories
  next

make_catalog = (files) ->
  translate_api = (file) ->
    Object.assign file, {
      label: (file.name.replace /^\d+_/, ''),
      url: "#{file.name}.#{file.hash}.html"
    }
  translate_api file for file in files

make_project_name = (settings) ->
  return null if fine.is_tourist
  settings.project_name

remove_unused_key = (sides) ->
  sides.map (side) ->
    delete side.path
    delete side.name
    delete side.hash
    side


# file = { path: string, name: string, hash: string, category?: string }
runtime = (files, settings) ->
  sides = make_catalog files
  sorted_sides = sortor.run sides
  archived_sides = sides_assign_category sorted_sides
  custom_sides = sides_assign_settings archived_sides, settings
  cleaned_sides = remove_unused_key custom_sides
  {
    sides: cleaned_sides
    project_name: make_project_name settings
    links: settings.links or []
  }


module.exports =
  run: runtime
