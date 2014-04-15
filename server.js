
var static = require('node-static');

var files = new static.Server('./build/public', { cache: 0 });

require('http').createServer(function (request, response) {
    request.addListener('end', function () {
        files.serve(request, response);
    }).resume();
}).listen(8080, function() {
    console.log("Deathcab running on http://localhost:8080");
});