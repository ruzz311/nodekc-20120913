# Server-side Code
ball =
  id: '123'
  field: 0             #screen[ 0 ]
  position: [ 50, 50 ] #percent
  acceleration: 0

fields = []
###
{
  player: "xxeadsfasdf",
  balls: [ 1, 2, 3 ]
  location: [0, 0],
  dimention: ['x', 'y']
}
###

players = {}

# Define actions which can be called from the client using ss.rpc('game.ACTIONNAME', param1, param2...)
exports.actions = (req, res, ss) ->

  # Example of pre-loading sessions into req.session using internal middleware
  req.use('session')

  # SUBS
  join: (player) ->
    console.log(req)
    req.session.channel.subscribe( req.session.id )
    
    #add player
    players[req.session.id] =
      id: req.session.id,
      dimention: [player.width, player.height]
      messages: []
    
    #push player id to fields ('linked-list-ish')
    fields.push req.session.id
    
    ss.publish.channel(req.session.id, 'ball.add', ball)
    
    # Broadcast the message to everyone
    ss.publish.all('newMessage', 'just joined the game', req.session.id)
    # Confirm it was sent to the originating client
    res(true)
    
  sendMessage: (message) ->
    # Check for blank messages
    if message && message.length > 0
      players[req.session.id].messages.push( message ) 
      ss.publish.all('newMessage', message, req.session.id)
      res(true)
    else
      res(false)
  
  
