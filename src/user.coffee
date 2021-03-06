db = require("./db")("#{__dirname}/../db/user")

module.exports =
  ###
    'get(username, callback)'
    ----------------------
    Parameters
    'username'  Username
    'callback'  Callback function
  ###
  get: (username, callback) ->
    user = {}
    rs = db.createReadStream()

    rs.on "data", (data) ->
      [_, _username] = data.key.split ":"
      [_pwd] = data.value.split ":"
      if _username == username
        user =
          username: _username
          pwd: _pwd
    rs.on "error", callback
    rs.on "close", ->
      callback null, user
  ###
    'save(username, password, callback)'
    ----------------------
    Parameters
    'username'  Username
    'password'  Password
    'callback'  Callback function
  ###
  save: (username, password, callback) ->
    ws = db.createWriteStream()

    ws.on "error", callback
    ws.on "close", callback

    ws.write
      key: "user:#{username}"
      value: "#{password}"
    ws.end()

  ###
    'remove(username, callback)'
    ----------------------
    Parameters
    'username'  Username
    'callback'  Callback function
  ###
  remove: (username, callback) ->
    toDel = [{type: "del", key: "user:#{username}"}]
    db.batch toDel, (err) ->
      callback err
