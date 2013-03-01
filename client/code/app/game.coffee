remote  = require('/remote')
chat    = require('/chat')
ball    = require('/ball')
t       = null
$me     = $('#me')

## Server communication
ss.rpc('game.join', { height: $(window).height(), width: $(window).width() })

updateLoop = ()->
  ball.update()
  
  # debugging
  $me
    .children('.x').empty().text( window.me[0] ).end()
    .children('.y').empty().text( window.me[1] ).end()
  
  # do it again
  t = setTimeout(updateLoop, 100)

#start position updates
updateLoop()