should = require('should')
user = require('../src/user.js')
describe 'my first text list', ->
  it 'should get a user with right parameters', (done) ->
    user.get 'Daniel', (res) ->
      res.should.equal 'Daniel'
      done()
      return
    return
  return
