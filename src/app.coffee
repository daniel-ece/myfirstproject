http = require('http')
user = require('./user.coffee')
http.createServer((req, res) ->
  user.get 'Daniel coffee-script', (id) ->
    res.writeHead 200, 'Content-Type': 'text/plain'
    res.end 'Hello ' + id
    return
  return
).listen 1337, '127.0.0.1'
