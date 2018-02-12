require("/bin/enderentities")
require("/bin/enderconsole")
require("/bin/enderstates")

function love.load()
	enderconsole.init()
	enderStates.Initialize()
	enderStates.LoadState(exampleState)
end

function love.update(dt)
	enderStates.Update(dt)
end

function love.draw()
	enderStates.Draw()
	enderconsole.draw()
end

function love.keypressed(key, scancode, isrepeat)
	enderStates.KeyPressed(key, scancode, isrepeat)
	enderconsole.keypressed(key)
end

function love.textinput(t)
	enderStates.TextInput(t)
	enderconsole.textinput(t)
end

function love.keyreleased(key, scancode)
	enderStates.KeyReleased(key, scancode)
end

function love.mousepressed(x, y, button, istouch)
	enderStates.MousePressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
	enderStates.MouseReleased(x, y, button, istouch)
end