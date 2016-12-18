#variables
metrics = require "../metrics"
user = require "../user"
userMetric = require "../user-metric"

express = require "express"
router = express.Router()

#router.get
router.get "/", (req, res) ->
  #if session
  if !req.session
    res.redirect "/signin"
  else
    res.redirect "/hello/" + req.session.username

#user metric get, post, delete
router.get "/user-metric", (req,res) ->
  userMetric.get req.session.username, (err, metricsId) ->
    if err
      res.status(404).send(err)
    else
      res.status(200).json metricsId

router.post "/user-metric", (req, res) ->
  userMetric.save req.session.username, req.body, (err)->
  if err
    res.status(404).send(err)
  else
    res.status(200).send()

router.delete "/user-metric/:id", (req,res) ->
  userMetric.remove req.session.username, req.params.id, (err) ->
    if err
      res.status(404).send(err)
    else
      res.status(200).send()

module.exports = router
