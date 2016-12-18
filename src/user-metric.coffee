db = require("./db")("#{__dirname}/../db/user-metric")

module.exports =
  ###
    'get(username, callback)'
    ----------------------
    Parameters
    'username'  Username
    'callback'  Callback function
  ###
  get: (username, callback) ->
    metricsId = []

    rs = db.createReadStream()

    rs.on "data", (data) ->
      [_, _username, _userMetricId] = data.key.split ":"
      if data.value and _username is username
        metricsId.push _userMetricId
    rs.on "error", callback
    rs.on "close", ->
      callback null, metricsId
  ###
    'save(username, mId, callback)'
    ----------------------
    Parameters
    'username'  Username
    'mId'       Id metric
    'callback'  Callback function
  ###
  save: (username, mId, callback) ->
    ws = db.createWriteStream()

    ws.on "error", callback
    ws.on "close", callback

    for m in mId
      ws.write
        key: "user-metric:#{username}:#{m}"
        value: true
    ws.end()
  ###
    'remove(username, mId, callback)'
    ----------------------
    Parameters
    'username'  Username
    'mId'       Id metric
    'callback'  Callback function
  ###
  remove: (username, mId, callback) ->
    db.del "user-metric:#{username}:#{mId}" , (err) ->
      callback(err)
