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
	local f = love.graphics.newFont(text_font,22*size)
	g.setFont(f)
	g.setColor(white_color)
end
function love.draw()
	g.print("New Highscore!",10*xsize,22*size)
	g.print("Position "..place.."  ::  "..points.." Points!",10*xsize,100*size)
	g.print("Press SPACE to continue!",10*xsize,290*size)
end
function love.keypressed(key)
	if (key == "return") or (key == "space") then
		intro_music:play()
		switchroom("Mainmenu")
	end
end
