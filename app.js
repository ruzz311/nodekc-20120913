// My SocketStream 0.3 app

var http = require('http'),
    ss = require('socketstream'),
    clients = require('./server/clients.json');

// Define clients automatically
  for(var i=0; i<clients.length; i++){
    ss.client.define( clients[i].id, clients[i].config )
  }

// Router
  ss.http.route('/', function(req, res) {
    if (req.headers['user-agent'].match(/iPhone/) || req.headers['user-agent'].match(/Android/)){
      console.log('mobile-client!!!!');
      res.serveClient('mobile');
    }else{
      console.log('desktop-client!!!!');
      res.serveClient('main');
    }
  });

// Code Formatters
  ss.client.formatters.add(require('ss-coffee'));
  ss.client.formatters.add(require('ss-jade'));
  ss.client.formatters.add(require('ss-stylus'));
  // Use server-side compiled Hogan (Mustache) templates. Others engines available
  ss.client.templateEngine.use(require('ss-hogan'));

// Minimize and pack assets if you type: SS_ENV=production node app.js
  if (ss.env === 'production') 
    ss.client.packAssets();

// Start web server
  var server = http.Server(ss.http.middleware);
  server.listen(3000);

// repl for debug
  var consoleServer = require('ss-console')(ss);
  consoleServer.listen(5000);

// Start SocketStream
ss.start(server);