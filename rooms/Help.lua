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
end
function love.draw()
	g.print("Snake",30,22*size-22)
	g.print("Made for Love 11.2",30*size,44*size)
	g.print("Eat the red fruit to become longer!",30*size,150*size)
	g.print("Don't bite yourself!",30*size,180*size)
	g.print("Press P to pause the game!",30*size,210*size)
end
function love.keypressed(key)
	switchroom("Mainmenu")
end
