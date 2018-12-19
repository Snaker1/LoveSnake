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

-- for switching between differnt states (mainmenu, options menu, the game)
function switchroom(room)
	-- clear old state
	love.update = nil
	love.draw = nil
	love.keypressed = nil
	-- load new room
	love.filesystem.load("rooms/"..room..".lua")()
	-- run the new love.load function
	love.load()
end
switchroom("load")
