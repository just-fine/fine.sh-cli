marked = require 'marked'
hljs = require 'highlight.js'

renderer = new marked.Renderer
_paragraph = renderer.paragraph
tips_reg = /^(\s*(?:!|#|\?))&gt;\s+/g
class_map =
  '#': 'info'
  '?': 'warning'
  '!': 'error'
renderer.paragraph = (text) ->
  return _paragraph text if not tips_reg.test text
  content = text.replace tips_reg, ''
  type = (text.match tips_reg).replace /\s/g, ''
  class_name = class_map[type[0]]
  
  "<p class=\"tips #{class_name}\">#{content}</p>"

marked.setOptions {
  gfm: true
  tables: true
  breaks: false
  pedantic: false
  sanitize: false
  smartLists: true
  smartypants: false
  renderer: renderer
  highlight: (code) ->
    (hljs.highlightAuto code).value
}


module.exports = marked
