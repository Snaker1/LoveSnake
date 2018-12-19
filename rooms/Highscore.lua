--[[
Copyright 2018 Martin Fibik <Martinfibk@web.de>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]--
function love.load()
	f = love.graphics.newFont(40*size)
	currb = 0
	for i = 1, 5 do 
		buttonf.new(i,60*xsize,45+(i*55-50/size)*size,200*xsize,45*size)
		buttonf.setxt(i,score[i],f)
	end
	for i = 6, 11 do 
		buttonf.new(i,10*xsize,46+((i-5)*55-50/size)*size,30*xsize,45*size)
		buttonf.setxt(i,i-5,f)
	end
end
function love.draw()
	buttonf.draw()
	g.printf("Highscore",0,2*size,426*size,"center")
end
function love.keypressed(key)
	switchroom("Mainmenu")
end
