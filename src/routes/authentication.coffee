#variables
user = require "../user"
express = require "express"
router = express.Router()

#router.get
router.get "/signup", (req, res) ->
  res.render "signup"

router.get "/signin", (req, res) ->
  res.render "signin"

router.get "/signout", (req, res) ->
  req.session.signIn = false
  delete req.session.username
  res.redirect "/signin"

#router.post
router.post "/signup", (req, res) ->
  user.save req.body.username, req.body.password, (err, value) ->
    if err
      res.redirect("/signup")
    else
      res.redirect("/hello/" + req.body.username)

router.post "/signin", (req, res) ->
  user.get req.body.username, (err, data) ->
    res.redirect "/signin" if err
    if !data.username
      res.redirect "/signin"
    else if data.pwd != req.body.password
      res.redirect "/signin"
    else
      req.session.signIn = true
      req.session.username = data.username
      res.redirect("/hello/" + req.body.username)

module.exports = router
