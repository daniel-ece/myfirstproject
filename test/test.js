var should = require('should');
var user = require('../src/user.js');


describe('my first text list with javascript', function(){
	it('should get a user with right parameters', function(done) {
			user.get("Daniel", function(res) {
			res.should.equal("Daniel");
			done();
		})
	})
});
