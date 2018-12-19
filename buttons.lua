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
g = love.graphics
buttons = {}
currb = 1
buttonf = { }
default_color = {}
default_color.txt = {0.78,0,0}
default_color.htxt = {0.78,0,0}
default_color.body = {0.78,0.78,0.78}
function buttonf.draw()
	for i = 1, #buttons do
		g.setColor(buttons[i].color.body[1],buttons[i].color.body[2],buttons[i].color.body[3],0.39)
		g.rectangle("fill", buttons[i][1], buttons[i][2], buttons[i][3], buttons[i][4], 10, 10, 128)
		if buttons[i].txt then
			g.setFont(buttons[i].font[1],buttons[i].font[2])
			if i == currb then
				g.setColor(buttons[i].color.htxt[1],buttons[i].color.htxt[2],buttons[i].color.htxt[3])
				g.rectangle("line", buttons[i][1], buttons[i][2], buttons[i][3], buttons[i][4], 10, 10, 128)
			else
				g.setColor(buttons[i].color.txt[1],buttons[i].color.txt[2],buttons[i].color.txt[3])
			end
			g.print(buttons[i].txt,buttons[i].txtX,buttons[i].txtY)
		end
	end
end

function buttonf.key(key,scancode)
	if ((scancode == "s") or (key == "down"))  and currb < #buttons then
			currb = currb + 1
			love.audio.play(change_sound)
		end
	if  ((scancode == "w") or (key == "up")) and currb > 1 then
			currb = currb - 1
			love.audio.play(change_sound)
		end
	if (key == "return") or (key == "space") then
		if buttons[currb].click then
			buttons[currb].click[1]()
		end
	end
end

function buttonf.new(pos,x,y,w,h)
	table.insert(buttons,pos,{x,y,w,h})
	buttons[pos].color = default_color
end
function buttonf.setxt(pos,txt,font)
	buttons[pos].txt = txt 
	if font then
		buttons[pos].font = {font}
	else
		buttons[pos].font = {f,12}
	end
	buttons[pos].txtX  = 
		(buttons[pos][1] + (buttons[pos][3] / 2)) -
		font:getWidth(buttons[pos].txt)/2  
	buttons[pos].txtY  = 
		(buttons[pos][2] + (buttons[pos][4] / 3))
		-(font:getHeight(buttons[pos].txt)/3  )
end
