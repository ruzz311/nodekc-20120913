#the gyroscope or accelerometer handler
tilt = (data)->
  console.log( "TILT!", data )

#Does the gyroscope or accelerometer actually work?
if (window.DeviceOrientationEvent)
  window.addEventListener("deviceorientation", 
    (e)-> tilt([e.beta, e.gamma]),
    true)
else if (window.DeviceMotionEvent)
  window.addEventListener('devicemotion', 
    (e)-> tilt([e.acceleration.x * 2, e.acceleration.y * 2]);
    true)
else
  window.addEventListener("MozOrientation", 
    ()-> tilt([orientation.x * 50, orientation.y * 50]);
    true);


## Server communication
# join message
ss.rpc('demo.join')



### QUICK CHAT DEMO ####
# Listen out for newMessage events coming from the server
ss.event.on 'newMessage', (message, user) ->

  # Example of using the Hogan Template in client/templates/chat/message.jade to generate HTML for each message
  html = ss.tmpl['chat-message'].render({message: message, user:user, time: -> timestamp() })

  # Append it to the #chatlog div and show effect
  $(html).hide().appendTo('#chatlog').slideDown()


# Show the chat form and bind to the submit action
$('#demo').on 'submit', ->

  # Grab the message from the text box
  text = $('#myMessage').val()

  # Call the 'send' funtion (below) to ensure it's valid before sending to the server
  exports.send text, (success) ->
    if success
      $('#myMessage').val('') # clear text box
    else
      alert('Oops! Unable to send message')


# Demonstrates sharing code between modules by exporting function
exports.send = (text, cb) ->
  if valid(text)
    ss.rpc('demo.sendMessage', text, cb)
  else
    cb(false)

# Private functions

timestamp = ->
  d = new Date()
  d.getHours() + ':' + pad2(d.getMinutes()) + ':' + pad2(d.getSeconds())

pad2 = (number) ->
  (if number < 10 then '0' else '') + number

valid = (text) ->
  text && text.length > 0