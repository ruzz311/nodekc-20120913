t = null
window.me = [0, 0]

verticalOffset = 40 #in degrees
horizontalOffset = -6

tilt = (data)-> 
  x = Math.min((data[0]-verticalOffset), 2)
  y = Math.min((data[1]-horizontalOffset), 2)
  
  window.me = [ Math.max(x,-3), Math.max(y,-3) ]

if window.DeviceOrientationEvent
  window.addEventListener "deviceorientation", 
    (e)-> tilt([e.beta, e.gamma]), 
    true 
else if window.DeviceMotionEvent
  window.addEventListener "devicemotion",
    (e)-> tilt([e.acceleration.x * 2, e.acceleration.y * 2]),
    true
else
  window.addEventListener "MozOrientation", 
    ()-> tilt([orientation.x * 50, orientation.y * 50]),
    true
