enderconsole = {}

enderconsole.display = false
enderconsole.key = "`"
enderconsole.str = ""
enderconsole.path = love.filesystem.getSaveDirectory() .. "/"
enderconsole.unhooked = {}

function enderconsole.EncodeKey(key)
	local key_encoded = ""

	key_encoded = key_encoded .. (love.keyboard.isDown("lctrl","rctrl") and "^" or "") .. key
	return key_encoded
end

function enderconsole.init()
	print(enderconsole.path)
end

function enderconsole.draw()
	local w = love.graphics.getWidth()
	if enderconsole.display == true then
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill", 0,0,w, 40)
		love.graphics.setColor(0,255,0)
		love.graphics.printf(enderconsole.str, 0, 0, w, "left")
		love.graphics.setColor(255,255,255)
	end
end

function enderconsole.keypressed(key)
	local key_encoded = enderconsole.EncodeKey(key)
	if key == "`" then
		enderconsole.toggleConsole()
	elseif (key_encoded == "^v") then
		enderconsole.str = love.system.getClipboardText()
	elseif key == "backspace" then
		if string.len(enderconsole.str) > 0 then
			enderconsole.str = string.sub(enderconsole.str, 1, string.len(enderconsole.str)-1)
		end
	elseif key == "return" and enderconsole.display == true then
		print("Running Code:" .. enderconsole.str)
		local success, message = love.filesystem.write("dev.lua", enderconsole.str)
		local chunk = love.filesystem.load("dev.lua", enderconsole.str)
		chunk()
		enderconsole.str = ""
		enderconsole.toggleConsole()
	end
end

function enderconsole.keyreleased(key) --REQUIRED ONLY FOR PASTE SUPPORT

end

function enderconsole.textinput(t)
	if not( t == "`") and enderconsole.display == true then
		enderconsole.str = enderconsole.str .. t
	end
end

function enderconsole.toggleConsole()
	enderconsole.display = not enderconsole.display
	if(enderconsole.display == true) then
		enderconsole.Hook()
	else
		enderconsole.UnHook()
	end
end

function enderconsole.Hook()
	enderconsole.unhooked.key_repeat = love.keyboard.hasKeyRepeat()
	enderconsole.unhooked.color = {love.graphics.getColor()}
	enderconsole.unhooked.update = love.update

	enderconsole.unhooked.keypressed = love.keypressed
	enderconsole.unhooked.keyreleased = love.keyreleased
	enderconsole.unhooked.textinput = love.textinput

	love.update = function(dt)

	end
	love.keypressed = enderconsole.keypressed
	love.keyreleased = enderconsole.keyreleased
	love.textinput = enderconsole.textinput
end

function enderconsole.UnHook()
	love.keyboard.setKeyRepeat(enderconsole.unhooked.key_repeat)
	love.graphics.setColor(enderconsole.unhooked.color)
	love.update = enderconsole.unhooked.update

	love.keypressed = enderconsole.unhooked.keypressed
	love.keyreleased = enderconsole.unhooked.keyreleased
	love.textinput = enderconsole.unhooked.textinput
end