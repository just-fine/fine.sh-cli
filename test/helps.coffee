
module.exports =
  pick: (type, string_val) ->
    reg = new RegExp "#{type}&&([\\s\\S]*)#{type}&&"
    return null if not reg.test string_val
    str = (string_val.match reg)[1]
    try
      (JSON.parse str).$$$
    catch err
      null

