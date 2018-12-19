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
	love.window.setTitle("Menu")
	default_color.body = {0.66, 0.66, 0.66}
	default_color.txt = {1,1,1}
	default_color.htxt = {0.86, 0, 0}
	currb = 1 -- tracks which button is active
	buttons = {}
	xsize = size*4/3
	button_font = love.graphics.newFont(32*size)
	logo_font = love.graphics.newFont('fonts/retroscape/Retroscape.ttf',36*size)
	options = {"Start","Highscore","Help","Options","End"}
	for i = 1, #options do 
	buttonf.new(i,60*xsize,60+(i*50-40/size)*size,200*xsize,40*size)
	buttonf.setxt(i,options[i],button_font)
	 buttons[i].click = {
			function() 
				buttons = {}
				switchroom(options[i])
			end
			}
	end
	logo_alpha = 0
end
function love.draw()
	g.setColor(0, 0.78, 0, logo_alpha)
	g.setFont(logo_font)
	love.graphics.printf(string.upper("-- Snake --"),0,10*size, 426*size,"center")
	buttonf.draw()
end
function love.update(dt)
	-- animate the logo
	if logo_alpha < 0.86 then
		logo_alpha = logo_alpha + dt*0.8
	end
end

function love.keypressed(key,scancode)
	buttonf.key(key,scancode)
	if key == "1" then
		size = 1
		xsize = size * (4/3)
		love.window.setMode(426,320)
		switchroom("Mainmenu")
	elseif key == "2" then
		size = 2
		xsize = size * (4/3)
		love.window.setMode(853,640)
		switchroom("Mainmenu")
	elseif key == "3" then
		size = 3
		xsize = size * (4/3)
		love.window.setMode(1280,960)
		switchroom("Mainmenu")
	elseif key == "4" then
		size = 4
		xsize = size * (4/3)
		love.window.setMode(1706,1280)
		switchroom("Mainmenu")
	elseif key == "f1" then
		switchroom("Help")
	elseif key == "escape" then
		love.event.push('quit')
	end
end
