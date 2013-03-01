_ = require 'underscore'


exports.actions = (req, res, ss)->
	
	#req.use 'session'
	
	return {
		# add a ball to the field
		add: ()->
			console.log 'rpc::ball.add'
			res("rpc::ball.add")
		
		# remove a ball to the field
		remove: (ballId)->
			console.log 'rpc::ball.remove'
			res("rpc::ball.remove")
		
		#update a ball's property
		update: (data)->
			# pos is an x,y coordinate to move the position to
			console.log 'rpc::ball.update'
			res("rpc::ball.update")
	}