should = require 'should'
user = require '../src/user.coffee'
describe 'my first text list with coffee-script', ->
  it 'should get a user with right parameters', (done) ->
    user.get 'Daniel', (res) ->
      res.should.equal 'Daniel'
      done()
      return
    return
  return
