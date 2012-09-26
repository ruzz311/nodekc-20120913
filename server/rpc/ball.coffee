_ = require 'underscore'

exports.actions = (req, res, ss)->
	
	req.use 'session'
	
	# add a ball to the field
	add: ()->
		console.log 'rpc::ball.add'
	
	# remove a ball to the field
	remove: (ballId)->
		console.log 'rpc::ball.remove'
	
	updatePosition: ( ballId, pos )->
		# pos is an x,y coordinate to move the position to
		console.log 'rpc::ball.updatePosition'
		
	updateField: ( ballId, pos )->
		# pos is a single integer, positive or negative describing the direction of
		# the previous or next screen
		console.log 'rpc::ball.updateField'