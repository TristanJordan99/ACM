box = {}
box.fillStyle = "fill"
box.x = 400
box.y = 300
box.w = 32
box.h = 32
box.speed = 128

box.spritesheet = love.graphics.newImage("rogue.png")
box.sprite = love.graphics.newQuad(0, 0, 32, 32, 320, 320)

box.animationFrames = {}
box.currentFrame = 0
box.animationFrames[0] = love.graphics.newQuad(0, 64, 32, 32, 320, 320)
box.animationFrames[1] = love.graphics.newQuad(32, 64, 32, 32, 320, 320)
box.animationFrames[2] = love.graphics.newQuad(64, 64, 32, 32, 320, 320)
box.animationFrames[3] = love.graphics.newQuad(96, 64, 32, 32, 320, 320)
box.animationFrames[4] = love.graphics.newQuad(128, 64, 32, 32, 320, 320)
box.animationFrames[5] = love.graphics.newQuad(160, 64, 32, 32, 320, 320)
box.animationFrames[6] = love.graphics.newQuad(192, 64, 32, 32, 320, 320)
box.animationFrames[7] = love.graphics.newQuad(224, 64, 32, 32, 320, 320)
box.animationFrames[8] = love.graphics.newQuad(256, 64, 32, 32, 320, 320)
box.animationFrames[9] = love.graphics.newQuad(288, 64, 32, 32, 320, 320)

timer = 0

function num(var)
  return var and 1 or 0
end

function love.load()

end

function love.update(dt)
	timer = timer + dt
	if timer>=0.1 then
		box.currentFrame = (box.currentFrame+1) % (#box.animationFrames+1)
		timer = 0
	end
	--Get Info
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	--Getting Input
	down = num(love.keyboard.isDown( "s" ))
	up = num(love.keyboard.isDown( "w" ))
	left = num(love.keyboard.isDown( "a" ))
	right = num(love.keyboard.isDown( "d" ))
	vertical = down-up
	horizontal = right-left
	
	--Collisions
	delta_x = box.speed*horizontal*dt
	delta_y = box.speed*vertical*dt
	new_x = box.x + delta_x
	new_y = box.y + delta_y
	
	if(new_x < 0) then
		new_x = 0
	elseif (new_x + box.w >  screenWidth) then
		new_x = screenWidth-box.w
	end
	
	if(new_y < 0) then
		new_y = 0
	elseif (new_y + box.h >  screenHeight) then
		new_y = screenHeight-box.h
	end
	
	
	--Move the Box
	box.x = new_x
	box.y = new_y
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(box.spritesheet, box.animationFrames[box.currentFrame], box.x, box.y)
end
















