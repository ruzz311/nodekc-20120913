window.balls = []

ss.event.on 'ball.add', ( ball )->
  # @TODO: remove
  console.log ball
  
  #create a ball
  ball =
    pos: [0,0], #position
    vel: [0,0], #velocity
    $el: $( "<div id='#{ball.id}'></div>" )
  
  # add the ball to the pool
  window.balls.push( ball )
  # add the ball to the view
  $('#balls').append( ball.$el )

exports.update = ->
  me = window.me
  
  $.each window.balls, ( i, ball )->
    x = ball.pos[0] = me[0] + ball.pos[0]
    y = ball.pos[1] = me[1] + ball.pos[1]
    
    if (x > 30 and x < 70) and (y > 30 and y < 70)
      console.log "GOOOOOOAAAALLLL"
      #i = 3
      ball.$el.addClass('disabled').text('goal')
    
    # update the server
    ss.rpc 'ball.update', { x:x, y:y }, ()->
      #console.log("yay", arguments)
      return
    
    # update the view      
    ball.$el.css
      top: (ball.pos[0])+"%"
      left: (ball.pos[1])+"%"
    