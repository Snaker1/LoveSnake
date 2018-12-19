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
function game_generateBackground()
	local screen_width, screen_height = g.getDimensions()
	local bgPoints = {}
	for a=1, 4 do -- every part of the background should have some points
		for b=1, 4 do
			for i=1, 2 do
				local x = love.math.random(5+(screen_width*(a-1)/4-5-100*xsize),
					(screen_width)*a/4-5-100*xsize)
				local y = love.math.random(5+screen_height*(b-1)/4,
					(screen_height-5)*(b/4))
				table.insert(bgPoints, {x, y})
			end
		end
	end
	return bgPoints
end

function snake_crash() -- snake was hitting itself or border
	love.audio.play(hit_sound)
	lives = lives - 1
	if lives == 0 then
		alive = false
		snake_death()
	else
		pos = {160*size,304*size}
		angle = 0
		points = points - 500
		game_pause()
	end
end
function love.load()
	love.audio.stop()
	love.window.setTitle("Snake")
	pos = {160*size,304*size} -- position of snake
	body = {{0,0}} -- body of the snake
	length = 3 -- start legth
	points = 0 -- score of player
	angle = 0 -- of snake
	dsize = 16 * size
	rsize = dsize
	if livemode == "single" then
		lives = 1
	elseif livemode == "multiple lives" then
		lives = 2
	else
		lives = math.huge -- infinity
	end
	alive = true
	pause = true
	fruit_pos = {math.random(1,18)*rsize, math.random(1,18)*rsize}
	fruit_alpha = 1
	font = g.newFont(text_font, 22*size)
	g.setFont(font)
	backgroundObj = game_generateBackground()
	hit_sound = love.audio.newSource("sound/hit.wav","static")
	ping_sound = love.audio.newSource("sound/ping.wav","static")
	background_music = love.audio.newSource("sound/Serge_Prokofiev_-_Toccata,_op._11_(Martha_Argerich,_1962).flac.ogg","stream")
	background_music:play()
	dtotal = 0 -- keeps track how much time passed since snake moved
end
function game_pause()
	pause = true
	background_music:pause()
end
function game_unpause()
	if pause then
		pause = false
		dtotal = 0
		background_music:play()
	end
end
function love.keypressed(key,scancode)
	if key == "p" or key == "space" then
		if pause then
			game_unpause()
		else
			game_pause()
		end
	elseif key == "escape" then
		love.audio.stop()
		intro_music:play()
		switchroom("Mainmenu")
	elseif key == "up" or scancode=="w" then
		if angle ~= 180 then
			angle = 0
		end
		game_unpause()
	elseif key == "left" or scancode=="a" then 
		if angle ~= 90 then
			angle = 270
		end
		game_unpause()
	elseif key == "down" or scancode=="s" then
		if angle ~= 0 then
			angle = 180
		end
		game_unpause()
	elseif key == "right" or scancode=="d" then
		if angle ~= 270 then
			angle = 90
		end
		game_unpause()
	end
end
function snake_death()
	local winner = false
	for i = 1, #score do -- check if highscore has been broken
		if points > tonumber(score[i]) then
			table.insert(score,i,points)
			table.remove (score,6)
			win=love.filesystem.write("highscore",score[1]..
			"\n"..score[2]..
			"\n"..score[3]..
			"\n"..score[4]..
			"\n"..score[5])
			place = i
			winner = true
			break
		end
	end
	love.timer.sleep(1)
	if winner then -- celebrate new highscore
		love.audio.stop()
		win_sound:play()
		switchroom("win")
	else
		love.audio.stop()
		intro_music:play()
		switchroom("Mainmenu")
	end
end
function love.update(dt)
	dtotal = dtotal + dt
	-- check if it is time for snake to move
	if not pause and (dtotal > (speed/1000)) then
		dtotal = dtotal - speed/1000
		table.insert(body,1,{pos[1],pos[2]})
		table.remove (body,length)
		if angle == 0 then
			pos[2] = pos[2]  - dsize
		elseif angle == 270 then 
			pos[1] = pos[1] - dsize
		elseif angle == 180 then
			pos[2] = pos[2] + dsize
		elseif angle == 90 then
			pos[1] = pos[1] + dsize
		end
		if pos[1]  >= 320 * size or pos[1] < 0 or
			pos[2] >= 320 * size or pos[2] < 0 then
			if borders == "yes" then
				snake_crash() 
			elseif borders == "no" then
				if angle == 0 then 
					pos[2] = 320 * size
				elseif angle == 180 then 
					pos[2] = 0
				elseif angle == 270 then 
					pos[1] = (320 * size)-dsize
				elseif angle == 90 then 
					pos[1] = 0
				end
			end
		end
		-- fruit eating
		if pos[1]  == fruit_pos[1] and pos[2] == fruit_pos[2] then 
			love.audio.play(ping_sound)
			fruit_pos = {math.random(1,18)*rsize, math.random(1,18)*rsize}
			fruit_alpha = 0
			length = length + 1
			local borderbonus = 0
			if borders == "yes" then
				borderbonus = 100
			end
			if livemode == "multiple lives" then
				points = points + (1000 - (speed*2))/2 + borderbonus
				if (length-3) % 25 == 0 then
					lives = lives + 1
					love.audio.play(win_sound)
				end
			else
				points = points + 1000 - (speed*2) + borderbonus
			end
		end
		-- check for collision
		for i = 1, #body  do 
			if pos[1] == body[i][1] and pos[2] == body[i][2]  then
				snake_crash()	
			end
		end
		-- animate the fruit
		if fruit_alpha < 1 then
			fruit_alpha = fruit_alpha + dt*12
		end
	end
end
function love.draw()
	g.setColor(0.39, 0.39, 0.39, 0.13)
	g.setPointSize(80*size)
	love.graphics.points(backgroundObj)
	g.setColor(0.098, 0.098, 0.098, 0.78)
	g.rectangle('fill', 321*size, 0, 322*size, 320*size )
	-- show score
	g.setColor(white_color)
	g.print("score", 332*size,22*size)
	g.print(points, 332*size,44*size)
	g.line( 321*size, 0, 322*size, 320*size )
	g.print("length", 332*size,78*size)
	g.print(length-3, 332*size,100*size)
	if livemode == "multiple lives" then
		g.print("lives", 332*size,134*size)
		g.print(lives, 332*size,156*size)
	end
	-- draw snake head
	g.setColor(0, 0.78, 0)
	g.rectangle("fill",pos[1], pos[2],dsize,dsize)
	g.setColor(0.78, 0.78, 0.78)
	g.rectangle("line",pos[1], pos[2],dsize,dsize)
	-- draw snake body
	for i = 1, #body , 1 do
		g.setColor(0, 0.49, 0)
		g.rectangle("fill",body[i][1],body[i][2],dsize,dsize)
		g.setColor(0.78, 0.78, 0.78)
		g.rectangle("line",body[i][1],body[i][2],dsize,dsize)
	end
	-- draw fruit
	g.setColor(0.78, 0, 0, fruit_alpha)
	g.rectangle("fill",fruit_pos[1],fruit_pos[2],dsize,dsize)
	g.setColor(0.78, 0.78, 0.78, fruit_alpha)
	g.rectangle("line",fruit_pos[1],fruit_pos[2],dsize,dsize)
	-- pause sign
	if pause then
		g.setColor(white_color)
		g.print("paused", 332*size,222*size)
	end
end
