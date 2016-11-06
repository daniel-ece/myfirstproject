http = require 'http'
user = require './user.coffee'
metrics = require './metrics.coffee'
express = require 'express'
bodyparser = require 'body-parser'

app = express()

app.use bodyparser.json()
app.use bodyparser.urlencoded()

app.set 'port', 1337
app.set 'view engine', 'pug'
app.set 'views', "#{__dirname}/../views"

app.use '/', express.static "#{__dirname}/../public"

app.get "/", (req, res) ->
  res.render "index", {}

app.get "/metrics(/:id)?", (req, res) ->
  metrics.get req.params.id, (err, value) ->
    throw next err if err
    res.status(200).json value

app.post "/metrics/:id", (req, res) ->
  metrics.put req.params.id, req.body, (err) ->
    throw next err if err
    res.status(200).send()

app.delete "/metrics/:id", (req,res) ->
  metrics.remove req.params.id, (ok) ->
    if ok
      res.status(200).send()
    else
      res.status(404).send()


app.listen app.get('port'), ->
  console.log "listening on port #{app.get 'port'}"
