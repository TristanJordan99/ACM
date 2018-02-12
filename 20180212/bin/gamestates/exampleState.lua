exampleState = {}

local button = {}
button.x = 400
button.y = 300
button.w = 128
button.h = 64
button.text = "Play"

function exampleState.Load()

end

function exampleState.Update(dt)

end

function exampleState.Draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", button.x, button.y, button.w, button.h)
	love.graphics.setColor(45,45,45)
	love.graphics.print( button.text, button.x, button.y)
end

function exampleState.KeyPressed(key, scancode, isrepeat)

end

function exampleState.KeyReleased(key, scancode)

end

function exampleState.MousePressed(x, y, mouse_button, istouch)
	print("state:" .. x .. "|".. y)
	if(isInBox(x, y, button.x, button.y, button.w, button.h)) then
		enderStates.LoadState(testingMainState)
	end
end

function exampleState.MouseReleased(x, y, button, istouch)

end

function isInBox(px,py,x,y,w,h)
	if(px > x and px < x+w) then
		if(px > y and py < y+h) then
			return true
		end
	end
	return false
end