display.setStatusBar( display.HiddenStatusBar )
--
function printT(t)
  for k, v in pairs(t) do
    if type(v) ~= 'table' and type(v) ~= 'boolean' then
     print (k..":"..v)
    else
       print (k)
    end  
  end
end
-------------------------
-- map
-------------------------
-- Load Lime
local lime = require("lime")
-- Debug mode
lime.enableDebugMode()
-- Disable culling
lime.disableScreenCulling()
-- Load your map
local map = lime.loadMap("tiledMeadow.tmx", "images/")
-- Create the visual
local visual = lime.createVisual(map)
--
t = map:getProperties()
--
tileHeight = map:getProperty("tileheight").value
tileWidth = map:getProperty("tilewidth").value
-------------------------
-- letuce collidable
-------------------------
letuces = map:getTileLayer("collidable")
-------------------------
-- Hedgehog
-------------------------
hedgehogObject = map:getObjectLayer("hedgehog")
object = hedgehogObject.objects[1]
hedgehog = display.newImage("images/hedgehog.png", object.x, object.y)
-------------------------
-- Snails
-------------------------
snail = require("snail")
snails = {}
objects = map:getObjectLayer("snails").objects
--
for i=1, #objects do
  --print (objects[i].x ..":"..objects[i].y)
  snails[i] = snail.new(objects[i].x,objects[i].y)
end
--
-- rectangle based collision check
--
function rectIntersectsRect(obj1, obj2)
    if obj1 == nil then
        return false
    end
    if obj2 == nil then
        return false
    end
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    return (left or right) and (up or down)
end
--
local isCollisionInArray = function(item) 
  if item.alpha ~= 0 then 
    for k, v in pairs (letuces.tileGrid) do
       for l, m in pairs (letuces.tileGrid[k]) do
          local obj1 = letuces.tileGrid[k][l]:getVisual()
          obj1.name = "letuces["..k.."]["..l.."]"
          if rectIntersectsRect(obj1, item) then
             return true
          end 
       end
    end    
   end  
   return false
end
--
Runtime:addEventListener("enterFrame", function() 
  for i=1, #snails do
    if snails[i].alpha ~= 0 then 
      -- check collision against lettuces
      local prevX, prevY = snails[i].x, snails[i].y
      snails[i]:move()
      if isCollisionInArray(snails[i]) then 
         snails[i].x = prevX; snails[i].y = prevY
      end
      -- check collision against hedgehog
      if rectIntersectsRect(snails[i], hedgehog) then
         snails[i].alpha = 0
      end
    end 
  end
end )
-------------------------
-- Joystick
-------------------------
joystick = require("myjoystick")
hedgehog.name = "hedgehog"
joystick.setTarget(hedgehog, 5, isCollisionInArray) -- target, speed