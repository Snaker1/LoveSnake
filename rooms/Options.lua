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
	love.window.setTitle("Options")
	save = ""
	moptions()
end
function moptions()
	buttons = { }
	f = love.graphics.newFont(22*size)
	options = 
	{"Windowsize: "..g.getWidth( ),
	"Live: "..livemode,"Border: "..borders,"Sound: "..audio,"Speed, move every: "..speed.."ms"}
	for i = 1, #options do 
		buttonf.new(i,25*xsize,30+(i*45-50)*size,270*xsize,40*size)
		buttonf.setxt(i,options[i],f)
	end
end
function love.draw()
	buttonf.draw()
	suchfont = love.graphics.newFont(text_font,22*size)
	g.setFont(f,22*size)
	g.setColor(white_color)
	g.setFont(suchfont,16*size)
	g.print("Press F5 to save",10*xsize,260*size)
	g.print("Press ESC to exit",10*xsize,290*size)
	g.print("LEFT/RIGHT keys to change option!",170*size,260*size)
	g.print(save,170*size,290*size)
end
function love.keypressed(key,scancode)
	buttonf.key(key,scancode)
	if (key == "left") or (scancode == "a") then
		save = ""
		if currb == 1 then
			if size == 2 then
				size = 1
				xsize = size * (4/3)
				love.window.setMode(426,320)
			elseif size == 3 then
				size = 2
				xsize = size * (4/3)
				love.window.setMode(853,640)
			elseif size == 4 then
				size = 3
				xsize = size * (4/3)
				love.window.setMode(1280,960)
			end
		elseif currb == 2 then
			if livemode == "multiple lives" then
				livemode = "single"
			elseif livemode == "godmode" then
				livemode = "multiple lives"
			end
		elseif currb == 3 then
			borders = "no"
		elseif currb == 4 then
			if audio == "on" then
				love.audio.setVolume(0)
				audio = "off"			
			end
		elseif currb == 5 then
			if speed > 25 then
				speed = speed - 25
			end
		end
		moptions() -- refresh the menu with new values
	elseif (key == "right") or (scancode == "d") then
		save = ""
		if currb == 1 then
			if size == 3 then
				size = 4
				xsize = size * (4/3)
				love.window.setMode(1706,1280)
			elseif size == 2 then
				size = 3
				xsize = size * (4/3)
				love.window.setMode(1280,960)
			elseif size == 1 then
				size = 2 
				xsize = size * (4/3)
				love.window.setMode(853,640)
			end
		elseif currb == 2 then
			if livemode == "multiple lives" and cheats then
				livemode = "godmode"
			elseif livemode == "single" then
				livemode = "multiple lives"
			end
		elseif currb == 3 then
			borders = "yes"
		elseif currb == 4 then
			if audio == "off" then
				love.audio.setVolume(1)
				audio = "on"
			end
		elseif currb == 5 then
			if speed < 400 then
				speed = speed + 25
			end
		end
		moptions() -- refresh the menu with new values
	elseif key == "escape" then
		switchroom("Mainmenu")
	elseif key == "c" then
		cheats = true
	elseif key == "f5" then
		love.filesystem.write("options",g.getWidth( )..
		"\n"..audio..
		"\n"..speed..
		"\n"..livemode..
		"\n"..borders) 
		save = "Saved!"
	end
end
