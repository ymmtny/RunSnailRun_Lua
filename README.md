RunSnailRun_Lua
===============

the following tizen javascript sample is a ported to corona sdk with lime https://developer.tizen.org/ja/documentation/articles/cocos2d-html5-game-framework-tizen-applications-introduction

you can get lime from https://github.com/OutlawGameTools/Lime2DTileEngine

Library for creating 2D tile-based games with Corona SDK. 
http://lime.outlawgametools.com

please merge with the following changes by ymmt

lime/lime-map.lua:
  210     if(nodeName == "tileset") then
  211       
  212:      tileSet = TileSet:new(node, self, nil, baseDirectory) -- ymmt
  213           
  214       self.tileSets[#self.tileSets + 1] = tileSet

lime/lime-utils.lua:
 1299     return require(_moduleName)
 1300   else
 1301:    return require(moduleName) -- ymmt  
 1302   end
 1303  
 
 
