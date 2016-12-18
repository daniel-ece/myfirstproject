#variables
metrics = require "../metrics"
user = require "../user"
userMetric = require "../user-metric"

express = require "express"
router = express.Router()

#router.get
router.get "/", (req, res) ->
  if !req.session
    res.redirect "/signin"
  else
    res.redirect "/hello/" + req.session.username

router.get "/user/:username", (req, res) ->
  user.get req.params.username, (err, value) ->
    if err
      res.status(404).send(err)
    else
      res.status(200).json value

router.get "/hello/:name",(req, res) ->
  res.render "hello",
    name: req.params.name

#router.delete
router.delete "/user/:username", (req,res) ->
  user.remove req.params.username, (err) ->
    if err
      res.status(404).send(err)
    else
      res.status(200).send()

module.exports = router
