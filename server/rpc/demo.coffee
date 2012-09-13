# Server-side Code

players = {}

# Define actions which can be called from the client using ss.rpc('demo.ACTIONNAME', param1, param2...)
exports.actions = (req, res, ss) ->

  # Example of pre-loading sessions into req.session using internal middleware
  req.use('session')

  # Uncomment line below to use the middleware defined in server/middleware/example
  #req.use('example.authenticated')
  players[req.sessionId] = { x:0, y:0 }

  ss.publish.all('connected', req.session)

  sendMessage: (message) ->
    console.log(req)
    if message && message.length > 0                      # Check for blank messages
      ss.publish.all('newMessage', message, req.sessionId)  # Broadcast the message to everyone
      res(true)                                           # Confirm it was sent to the originating client
    else
      res(false)

  join: () ->
    console.log(req)
    ss.publish.all('newMessage', 'just joined the game', req.sessionId)  # Broadcast the message to everyone
    res(true)                                           # Confirm it was sent to the originating client
