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
	g = love.graphics
	-- check existence
	if love.filesystem.getInfo("options") then
		lines = {} 
		for line in love.filesystem.lines("options") do 
			table.insert(lines, line) 
		end 
		if lines[1] == "853" then
			love.window.setMode(853,640)
			size = 2
		elseif lines[1] == "1280" then
			love.window.setMode(1280,960)
			size = 3
		elseif lines[1] == "1706" then
			size = 4
			love.window.setMode(1706,1280)
		else
			size = 1
		end
		audio = lines[2]
		if audio == "on" then
			love.audio.setVolume( 1 )
		end
		if audio == "off" then
			love.audio.setVolume( 0 )
		end
		speed = tonumber(lines[3])
		livemode = lines[4]
		borders = lines[5]
	else
		love.window.setMode(853,640)
		size = 2 
		xsize = size * (4/3)
		speed = 100
		audio = "on"
		love.audio.setVolume( 1 )
		livemode = "single"
		borders = "yes"
	end
	-- check existence
	if love.filesystem.getInfo("highscore") then
		score = {} 
		for line in love.filesystem.lines("highscore") do 
			table.insert(score, line) 
		end 
	else
		score = {0,0,0,0,0}
	end
	love.filesystem.load("buttons.lua")()
	text_font = 'fonts/Horta demo.ttf'
	select_sound = love.audio.newSource("sound/select.wav","static")
	change_sound = love.audio.newSource("sound/change.wav","static")
	win_sound = love.audio.newSource("sound/win.wav","static")
	intro_music = love.audio.newSource("sound/puppydawgs.ogg","stream")
	intro_music:setVolume(0.4)
	intro_music:play()
	white_color = {0.98, 0.98, 0.98}
	switchroom("Mainmenu")
end
