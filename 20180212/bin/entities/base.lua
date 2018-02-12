local base = {}

base.x = 0
base.y = 0
base.health = 1

function base:setPos( x, y)
	base.x = x
	base.y = y
end

function base:getPos()
	return base.x, base.y;
end

function base:setSize( w, h)
	base.w = w
	base.h = h
end

function base:getSize()
	return self.w, self.h;
end

function base:load( x, y)
	self:setPos( x, y)
	self.EntityID = "base"
end

function base:getCenter()
	local x = self.x + self.w/2
	local y = self.y + self.h/2
	return x,y
end

function base:setColl(bool, side)
	if side == "top" then self.collTop = bool
	elseif side == "bottom" then self.collBottom = bool
	elseif side == "left" then self.collLeft = bool
	elseif side == "right" then self.collRight = bool
	end
end

return base;