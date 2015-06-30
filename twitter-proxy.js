var http_proxy = require('http-proxy');
var https = require('https');
var http = require('http');

var conficuration = {
  key: "AIzaSyDSfdDUlJ_7nmhrvUOE-XNa2o4bCnobl8A",
  port: 7777
};

var options = {
  target:    'https://api.twitter.com',
  agent  :   https.globalAgent,
  headers: {
    Origin: 'http://127.0.0.1',
    host:   'api.twitter.com'
  }
};

var Origin = "Origin";
var referer = "referer";

var known_client_hosts = {
  Origin:[],
  referer:[]
};

function log_host(addres, type){
  console.log("");
  console.log(new Date());
  console.log("new <" + type + "> host: " + addres);
}

function register_host(addres, type){
  for (var i = 0; i < known_client_hosts[type].length; i++) {
    if(known_client_hosts[type][i] == addres){
      return;
    }
  }
  known_client_hosts[type].push(addres);
  log_host(addres, type);
}

var proxy = http_proxy.createProxyServer({});

function onProxyRes(proxyRes, req, res, options) {
  proxyRes.headers["Access-Control-Allow-Origin"]  = "*";
  proxyRes.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS, PATCH";
  proxyRes.headers["Access-Control-Allow-Headers"] = "x-requested-with, Authorization, Content-Type, accept";
}

function onProxyReq(proxyReq, req, res, options) {
  var temp = proxyReq;
  //adding 'key' as query parameter
  //proxyReq.path += "&key=" + conficuration.key;
}

proxy.on('proxyRes', onProxyRes);
proxy.on('proxyReq', onProxyReq);


function handle_options(response){
  cors_headers = {
    "Access-Control-Allow-Origin" : "*",
    "Access-Control-Allow-Methods" : "GET, POST, PUT, DELETE, OPTIONS, PATCH",
    "Access-Control-Allow-Headers" : "x-requested-with, Authorization, Content-Type, accept"
  };
  response.writeHead(200, cors_headers);
  response.end();
}

function handle_root(response){
  var text = 'tac-videos';
  var cors_headers = {
    "Access-Control-Allow-Origin" : "*",
    "Access-Control-Allow-Methods" : "GET, POST, PUT, DELETE, OPTIONS, PATCH",
    "Access-Control-Allow-Headers" : "x-requested-with, Authorization, Content-Type, accept",
    "content-length": text.length
  };
  response.writeHead(200, cors_headers);
  response.end(text);
}

function client_listener(client) {
  register_host(client.request.headers.origin, Origin);
  register_host(client.request.headers.referer, referer);
  if (client.request.method == 'OPTIONS') {
    handle_options(client.response);
  }
  else if (client.request.url == '/') {
    handle_root(client.response);
  }
  else {
    proxy.web(client.request, client.response, options);
  }
}

function wrapp_client(handler){
  return function(request, response){
    var client = {
      request: request,
      response: response
    };
    handler(client);
  };
}

var server = http.createServer(wrapp_client(client_listener));

console.log("listening on port " + conficuration.port);

server.listen(conficuration.port);