local ent = enderents.Derive("base")

function ent:load( x, y)
	self:setPos( x, y)
	self:setSize(64,64)
	self.dX, self.dY = 0, 0
	self.maxVel = 256
	self.gravity = 16
	self.maxMoveSpeed = 128
	self.accel = 16
	self.friction = 8
	self.jumpHeight = 512
	self.isJumping = false
	self.EntityID = "PlayerController"
	self.color = {0,255,0}
	self.controls = {'a','d',{'w','space'},'enter'}
end

function ent:respawn(x, y)
	self:setPos(x,y)
end

function ent:setControls(c)
	self.controls = c
end



function ent:update(dt)
	self.collBottom = false
	self.collLeft = false
	self.collRight = false
	self.collTop = false
	local x, y = self:getPos()
	local w, h = self:getSize()
	local centerX = x + w/2
	local centerY = y + h/2
	local sW, sH = love.graphics.getDimensions() --Screen Width and Height
	enderents.getCollisions(self) --Get Entity Collisions
	--[[Physics]]--
	if self.collBottom == false then
		if self.dY < self.maxVel then
			self.dY = self.dY+self.gravity --GRAVITY
		end
	else
		if math.abs(self.dY) == self.dY then --If these are the same then dY is positive, and player is moving down
			self.dY = 0 --Don't keep moving down if collBottom is true
		end
		self.isJumping = false
	end
	
	if self.collTop == true then
		if not (math.abs(self.dY) == self.dY) then --If these are the different then dY is negative, and player is moving up
			self.dY = 0 --Don't keep moving up if collTop is true
		end	
	end
	
	if self.collRight == true then
		if math.abs(self.dX) == self.dX then --If these are the same, positive. therefore moving right
			self.dX = 0
		end
	end
	
	if self.collLeft == true then
		if not (math.abs(self.dX) == self.dX) then --If these are different, negative. therefore moving left
			self.dX = 0
		end
	end
	
	local dir = 0
	if math.abs(self.dX) == self.dX then dir = 1 else dir = -1 end
	if math.abs(self.dX) > 1 then self.dX = self.dX - self.friction*dir else self.dX = 0 end
	
	--[[Do Movement]]--
	
	self.y = self.y + self.dY*dt
	self.x = self.x + self.dX*dt
	
	--[[Keyboard Actions]]--
	if(love.keyboard.isDown(self.controls[1]) == true) and (self.dX > -1*self.maxMoveSpeed) then --Left Movement
		self.dX = self.dX - self.accel
	end
	if(love.keyboard.isDown(self.controls[2]) == true) and (self.dX < self.maxMoveSpeed) then --Right Movement
		self.dX = self.dX + self.accel
	end
	if(love.keyboard.isDown(self.controls[3]) == true) and self.isJumping == false then --Jump
		self.dY = self.jumpHeight*-1
		self.isJumping = true
	end
end

function ent:draw()
	local x, y = self:getPos()
	local w, h = self:getSize()
	
	love.graphics.setColor( self.color)
	love.graphics.rectangle("fill", x, y, w, h)
end

function ent:keypressed(key)
	if key == self.controls[4] then print(self.id .. " fired") end
	
end

return ent;