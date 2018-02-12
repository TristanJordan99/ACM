local ent = enderents.Derive("base")

function ent:load( x, y , args)
	self:setPos( x, y)
	self.EntityID = "box"
	if not (args[1] == nil) then self.w = args[1] else self.w = 64 end
	if not (args[2] == nil) then self.h = args[2] else self.h = 64 end
	print("Box created with dimensions: " .. self.w .. "," .. self.h)
end

function ent:getSize()
	return self.w, self.h;
end

function ent:update(dt)
end

function ent:draw()
	local x, y = self:getPos()
	local w, h = self:getSize()
	
	love.graphics.setColor( 0, 0, 0, 255)
	love.graphics.rectangle("fill", x, y, w, h)
end

return ent;