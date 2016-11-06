levelup = require "levelup"
levelws = require "level-ws"

db = levelws levelup "#{__dirname}/../db/dbmetrics"

module.exports =
  ###
  'put(id, metrics, callback)'
  ----------------------------
  Parameters
  'id'       Metric id as integer
  'metrics'  Array with timestamp as keys
             and integer as values
  'callback' Contains an err as first argument
             if any
  ###
  put: (id, metrics, callback) ->
    ws = db.createWriteStream()

    ws.on 'error', callback
    ws.on 'close', callback

    for m in metrics
      {timestamp, value} = m
      ws.write
        key: "metric:#{id}:#{timestamp}"
        value: value
    ws.end()

  ###
    'get(id, callback)'
    --------------------------------
    Parameters
    'id'       Metric id as integer
    'callback' Callback function
  ###
  get: (id, callback) ->
    metrics = []
    if id
      options =
        gte: "metric:#{id}"
        lt: "metric:#{parseInt(id) + 1}"
    else
      options = {}

    rs = db.createReadStream options

    rs.on 'data', (data) ->
      [_, _id, timestamp] = data.key.split ':'
      metrics.push
        id: _id
        timestamp: timestamp
        value: data.value
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, metrics

  ###
    'remove(id, callback)'
    ----------------------
    Parameters
    'id'        Metric id as integer
    'callback'  Callback function
  ###
  remove: (id, callback) ->
    this.get id, (err, metrics) ->
      if !metrics.length
        callback false
        return

      toDelete = []
      for m in metrics
        key = "metric:#{m.id}:#{m.timestamp}"
        toDelete.push {type: 'del', key: key}
      db.batch toDelete, (err) ->
        callback !err
