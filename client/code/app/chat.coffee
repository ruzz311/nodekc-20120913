###
worker = ss.load.worker '/pi.coffee';
# print output to console
worker.addEventListener 'message', (e)-> console.log(e.data)
# start worker with 10000000 cycles
worker.postMessage(10000000);
###

## Server communication
ss.event.on 'newMessage', (message, user) ->
  # Example of using the Hogan Template + Jade to generate HTML for each message
  html = ss.tmpl['chat-message'].render({message: message, user:user, time: -> timestamp() })
  # Append it to the #chatlog div and show effect
  $(html).hide().prependTo('#chatlog').slideDown()


### QUICK CHAT DEMO ####

# Show the chat form and bind to the submit action
$('#chat').on 'submit', ->
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
    ss.rpc('game.sendMessage', text, cb)
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