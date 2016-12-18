#variables
http = require "http"
express = require "express"
morgan = require "morgan"
bodyparser = require "body-parser"
cookieParser = require "cookie-parser"

app = express()
server = require("http").Server(app)
io = require("socket.io")(server)

#configuration of session db
session = require "express-session"
LevelStore = require("level-session-store")(session)

app.use session
  secret: "MyAppSecret"
  store: new LevelStore "./db/sessions"
  resave: true
  saveUninitialized: true

#check authentication
authenticationCheck = (req, res, next) ->
  if req.session.signIn == false
    res.redirect "/signin"
  else
    next()

#use
app.use "/", express.static "#{__dirname}/../public"
app.use bodyparser.json()
app.use bodyparser.urlencoded()
app.use cookieParser()

app.use require("./routes/authentication.coffee")
app.use authenticationCheck, require("./routes/user.coffee")
app.use authenticationCheck, require("./routes/user-metrics.coffee")

#set
app.set "port", 1337
app.set "view engine", "pug"
app.set "views", "#{__dirname}/../views"

#start server
server.listen app.get("port"), ->
  console.log "listening on port #{app.get "port"}"
