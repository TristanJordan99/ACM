box = {}
box.fillStyle = "fill"
box.x = 400
box.y = 300
box.w = 16
box.h = 16
box.speed = 64

function num(var)
  return var and 1 or 0
end

function love.load()

end

function love.update(dt)
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
	love.graphics.rectangle(box.fillStyle,box.x,box.y,box.w,box.h)
end