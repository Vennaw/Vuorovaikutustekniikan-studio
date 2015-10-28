//Start node for testing locally
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var port = 8080;

var io = require('socket.io')(server); // initiate socket.io server

io.on('connection', function (socket) {

  // wait for the event raised by the client
  socket.on('identify', function (data) {  
    identify(data, function (err, httpResponse, body) {
  		if (err) console.log(err);
  		socket.emit('response', body);
	});
  });
});

var url = require('url');
var fs = require('fs');
var crypto = require('crypto');
//npm install request
var request = require('request');

server.listen(port, function () {
  console.log('Server listening at port %d', port);
});

// Routing
app.use(express.static(__dirname ));

var defaultOptions = {
  host: 'ap-southeast-1.api.acrcloud.com',
  endpoint: '/v1/identify',
  signature_version: '1',
  data_type:'audio',
  secure: true,
  access_key: '67fb3b6f66e9186b928295b51f692657',
  access_secret: '7NvyKfLs3cfBmzMN6h0l9yKhgN6zRxO2yvLBRHPR'
};

function buildStringToSign(method, uri, accessKey, dataType, signatureVersion, timestamp) {
  return [method, uri, accessKey, dataType, signatureVersion, timestamp].join('\n');
}

function sign(signString, accessSecret) {
  return crypto.createHmac('sha1', accessSecret)
    .update(new Buffer(signString, 'utf-8'))
    .digest().toString('base64');
}

/**
 * Identifies a sample of bytes
 */
function identify(data, cb) {
  var options = defaultOptions;
  var current_data = new Date();
  var timestamp = current_data.getTime()/1000;

  var stringToSign = buildStringToSign('POST',
    options.endpoint,
    options.access_key,
    options.data_type,
    options.signature_version,
    timestamp);

  var signature = sign(stringToSign, options.access_secret);

  var formData = {
    sample: data,
    access_key:options.access_key,
    data_type:options.data_type,
    signature_version:options.signature_version,
    signature:signature,
    sample_bytes:data.length,
    timestamp:timestamp,
  }
  request.post({
    url: "http://"+options.host + options.endpoint,
    method: 'POST',
    formData: formData
  }, cb);
}