local _joystick ={}
--
local joystickClass = require( "joystick" )
--
_joystick.setTarget = function (target, speed, isCollisionInArray)
  local function moveTarget( event )
    local Speed = event.speed
    local target = event.target
    local isCollisionInArray = event.isCollisionInArray
    local xAmount, yAmount = event.joyX, event.joyY
    --
    if type(xAmount) == "number" then
      xAmount = xAmount * Speed
    end
    --
    if type(yAmount) == "number" then
      yAmount = -yAmount * Speed 
    end
    --
    if type(yAmount) == "number" and type(xAmount) == "number" then
      target.x = target.x + xAmount
      target.y = target.y - yAmount
      if isCollisionInArray(target) then 
        target.x = target.x - xAmount
        target.y = target.y + yAmount
       end
     end
  end
  -- Add A New Joystick
  _joystick.mapJoystick = joystickClass.newJoystick
  {
    outerImage = "images/joystickOuter.png",   
    outerAlpha = 0.8,           
    innerImage = "images/joystickInner.png",   
    innerAlpha = 0.8,           
    position_x = display.contentWidth-100,            
    position_y = display.contentHeight-100,           
    onMove = moveTarget            
  }
  --
  _joystick.mapJoystick.xScale = 0.7
  _joystick.mapJoystick.yScale = 0.7
  _joystick.mapJoystick.target = target
  _joystick.mapJoystick.speed = speed
  _joystick.mapJoystick.isCollisionInArray = isCollisionInArray
end
return _joystick
