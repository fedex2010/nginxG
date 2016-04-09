// Load the http module to create an http server.
var http = require('http');

// Configure our HTTP server to respond with Hello World to all requests.
var server = http.createServer(function (req, response) {
 console.log(req.method, " ", req.url);
 response.writeHead(200, {"Content-Type": "application/json"});
 response.end(JSON.stringify({ 
  	"headers": req.headers, 
  	"url": req.url, 
  	"method": req.method, 
  	"host": req.hostname, 
  	"protocol": req.protocol
  }));
});

// Listen on port 8000, IP defaults to 127.0.0.1
server.listen(3000);

// Put a friendly message on the terminal
console.log("Server running at http://127.0.0.1:3000/");