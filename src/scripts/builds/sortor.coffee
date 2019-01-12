weight_reg = /(^\d+)_[\s\S]*/

make_weight = (file) ->
  weight = 10
  if weight_reg.test file.name
    weight = (file.name.match weight_reg)[1]
  Object.assign file, { weight }

# file = { name: string ... }
# out = { name: string, order: number, ... }
order = (files) ->
  files = (make_weight file for file in files)
  files


module.exports =
  run: order
