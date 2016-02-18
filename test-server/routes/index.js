var express = require('express');
var router = express.Router();

/* GET home page. */
router.all('/*', function(req, res, next) {
  res.send( { 
  	"headers": req.headers, 
  	"url": req.url, 
  	"method": req.method, 
  	"host": req.hostname, 
  	"protocol": req.protocol
  } )
});

module.exports = router;
