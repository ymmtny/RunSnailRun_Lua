local function init (obj)
    obj.width = 30
    obj.height = 30
    obj.vx = math.random() - 0.5
    obj.vy = math.random() - 0.5
end
--
local _snail = {
    new = function(x, y) 
        local _dispObj = display.newImage("images/snail.png", x, y)
        init (_dispObj)
   
        _dispObj.getContentSize = function ()
          return {height = this.dispObj.height , width = this.dispObj.width}
        end 

        _dispObj.getPosition = function ()
          return {x = this.dispObj.x, y = this.dispObj.y}    
        end

       _dispObj.collideRect = function()
            local a = this.getContentSize();
            local p = this.getPosition();
            return {p.x - a.width / 2, p.y - a.height / 2, a.width,
                    a.height}
        end    

        _dispObj.move = function() 
             local this = _dispObj
             local DAMP = 0.99;
             this.vx = this.vx + math.random() * 0.5 - 0.25
             this.vy = this.vy + math.random() * 0.5 - 0.25
             this.x = this.x + this.vx
             this.y = this.y + this.vy

             this.vx = this.vx * DAMP
             this.vy = this.vy * DAMP
            
             if this.x < 50 then 
                 this.vx =  this.vx * -1 
             elseif  this.x > 1200 then 
                 this.vx = this.vx * -1
             end  
          
             if this.y < 50  then 
                 this.vy = this.vy * -1 
             elseif this.y > 600  then
                this.vy =  this.vy * -1 
             end 
            
             if  this.x < 0 then 
                 this.x =  0
             elseif this.x > display.contentWidth then 
                 this.x = display.contentWidth
             end 

             if this.y < 0 then 
                this.y =  0
             elseif this.y > display.contentHeight then 
                 this.y =  display.contentHeight
             end 
         end
       
      return _dispObj
    end,
}    
return _snail