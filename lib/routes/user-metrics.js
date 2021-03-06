// Generated by CoffeeScript 1.11.1
(function() {
  var express, metrics, router, user, userMetric;

  metrics = require("../metrics");

  user = require("../user");

  userMetric = require("../user-metric");

  express = require("express");

  router = express.Router();

  router.get("/", function(req, res) {
    if (!req.session) {
      return res.redirect("/signin");
    } else {
      return res.redirect("/hello/" + req.session.username);
    }
  });

  router.get("/user-metric", function(req, res) {
    return userMetric.get(req.session.username, function(err, metricsId) {
      if (err) {
        return res.status(404).send(err);
      } else {
        return res.status(200).json(metricsId);
      }
    });
  });

  router.post("/user-metric", function(req, res) {
    userMetric.save(req.session.username, req.body, function(err) {});
    if (err) {
      return res.status(404).send(err);
    } else {
      return res.status(200).send();
    }
  });

  router["delete"]("/user-metric/:id", function(req, res) {
    return userMetric.remove(req.session.username, req.params.id, function(err) {
      if (err) {
        return res.status(404).send(err);
      } else {
        return res.status(200).send();
      }
    });
  });

  module.exports = router;

}).call(this);
