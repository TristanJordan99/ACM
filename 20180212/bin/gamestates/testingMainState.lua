testingMainState = {}

function testingMainState.Load()
	enderents.Startup()
	local PlayerController = enderents.Create("PlayerController", 200, 64)
	local PlayerController = enderents.Create("PlayerController", 600, 64)
	enderents.getPlayerObjects()[2].controls = {"left","right",{"up"},"kpenter"} --Set controls for player 2
	local topBound = enderents.Create("box", 0, 0-16, 1600, 32)
	local bottomBound = enderents.Create("box", 0, 600-16, 1600, 32)
	local leftBound = enderents.Create("box", 0-16, 0, 32, 600)
	local rightBound = enderents.Create("box", 800-16, 0, 32, 600)
	enderents.Create("box", 800/2-16, 600/2-16, 32, 32)
end

function testingMainState.Update(dt)
	enderents:update(dt)

end

function testingMainState.Draw()
	love.graphics.setBackgroundColor(80,80,80)
	enderents:draw()
end

function testingMainState.KeyPressed(key, scancode, isrepeat)
	enderents:keypressed(key)
	
	--An example of how to apply knockback to player 1
	if (key == "t") then
		enderents.applyForce(enderents.getPlayerObjects()[1], 45, 5)
	end
end

function testingMainState.KeyReleased(key, scancode)

end

function testingMainState.MousePressed(x, y, button, istouch)

end

function testingMainState.MouseReleased(x, y, button, istouch)

end
