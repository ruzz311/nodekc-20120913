t = null
remote = require('/remote')
chat = require('/chat')
ball = require('/ball')

## Server communication
ss.rpc('game.join', { height: $(window).height(), width: $(window).width() })

$me = $('#me')

updateView = ()->
  ball.update()  
  # debugging
  $me
    .children('.x').empty().text( window.me[0] ).end()
    .children('.y').empty().text( window.me[1] ).end()
  
  # do it again
  t = setTimeout( updateView, 100 )

#start position updates
updateView()