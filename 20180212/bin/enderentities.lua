 enderents = {}
 enderents.objects = {}
 enderents.objpath = "bin/entities/"
 local register = {}
 local id = 0
 
 function enderents.Startup()
	register["box"] = love.filesystem.load(enderents.objpath  .. "box.lua")
	register["PlayerController"] = love.filesystem.load(enderents.objpath  .. "PlayerController.lua")
	register["PlayerController_TD"] = love.filesystem.load(enderents.objpath  .. "TopDown_PlayerController.lua")
 end
 
 function enderents.Derive(name)
	return love.filesystem.load(enderents.objpath .. name .. ".lua")()
 end
 
 function enderents.Create(name, x, y, ...)
	local args = {...}
	if not x then
		x = 0
	end
	if not y then
		y = 0
	end
	print(unpack(args))
	if register[name] then
		id = id + 1
		local ent = register[name]()
		ent:load(x, y, args )
		ent.id = id
		enderents.objects[#enderents.objects + 1] = ent
		return enderents.objects[#enderents.objects]
	else
		print("Error: Entity" .. name .. "does not exist")
		return false
	end
 end
 
function enderents.Clear()
	for k,v in pairs(enderents.objects) do enderents.objects[k]=nil end
	print(#enderents.objects)
end
 
 function enderents:update(dt)
	for i, ent in pairs(enderents.objects) do
		if ent.update then
			ent:update(dt)
		end
	end
end

 function enderents:draw()
	for i, ent in pairs(enderents.objects) do
		if ent.draw then
			ent:draw()
		end
	end
end

function enderents:keypressed(key)
	for i, ent in pairs(enderents.objects) do
		if ent.keypressed then
			ent:keypressed(key)
		end
	end
end


function enderents.getPlayerObjects()
	local playerObjects = {}
	for k, v in pairs(enderents.objects) do
		if v.EntityID == "PlayerController" then
			playerObjects[#playerObjects + 1] = v
		end
	end
	return playerObjects
end

function enderents.getObjByID(id)
	for k, v in pairs(enderents.objects) do
		if v.id == id then
			return v
		end
	end
	return "error"
end

--[[///////////////////////////////////////
//////////PHYSICS FUNCTIONS////////////////
///////////////////////////////////////////]]--

--Function only applies for "tables" with a dX and dY component
function enderents.applyForce(target_object, degrees, magnitude) 
	if target_object.dX then	
		target_object.dX = target_object.dX + math.cos(math.rad(degrees))*magnitude*100
	end
	if target_object.dY then
		target_object.dY = target_object.dY - math.sin(math.rad(degrees))*magnitude*100
	end
end

--Largely inspired by: http://hugobdesigner.blogspot.com.br/2014/10/making-simple-2d-physics-engine.html
function enderents.getCollisions(obj)
	local x1, y1 = obj:getPos()
	local w1, h1 = obj:getSize()
	local collision = false
	local collidedWith = {}
	for index, obj2 in pairs(enderents.objects) do
		if not (obj2.id == obj.id or obj2.static) then
			local x2, y2 = obj2:getPos()
			local w2, h2 = obj2:getSize()
			collision = enderents.checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
			if collision == true then  
				collidedWith[#collidedWith+1] = obj2
				bump(obj, obj2)
			end 				  
		end
	end
	return collidedWith
end


function enderents.checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)  
    local collided = false  
    local p1x, p1y = math.max(x1, x2), math.max(y1, y2)  
    local p2x, p2y = math.min(x1+w1, x2+w2), math.min(y1+h1, y2+h2)  
    local sideBySide = false  
       
    if sideBySide then  
        if p2x-p1x >= 0 and p2y-p1y >= 0 then  
            collided = true  
        end  
    else  
        if p2x-p1x > 0 and p2y-p1y > 0 then  
            collided = true  
        end  
    end        
    return collided  
end  

function getCollisionDirection(obj1, obj2)
	local x1, y1 = obj1:getPos()	
	local w1, h1 = obj1:getSize()
	local x2, y2 = obj2:getPos()
	local w2, h2 = obj2:getSize()
	local left = (x1+w1) - x2
	local right = (x2+w2) - x1  
	local bottom = (y1+h1) - y2  
	local top = (y2+h2) - y1  
		
	if right < left and right < top and right < bottom then  
		--Right collision for obj1, left for obj2  
		obj1:setColl(true, "right")
		return("right")
	elseif left < top and left < bottom then  
		--Left collision for obj1, right for obj2  
		obj1:setColl(true, "left")
		return("left")
	elseif top < bottom then  
		obj1:setColl(true, "top")
		return("top")
	elseif bottom < top then
		--Bottom collision for obj1, top for obj2  
		obj1:setColl(true, "bottom")
		return("bottom")
	end
end

function bump(obj1, obj2)  
	local dir = getCollisionDirection(obj1, obj2)  
	--This will return the direction of the collision  
        
	local width = math.min(obj1.x+obj1.w, obj2.x+obj2.w) - math.max(obj1.x, obj2.x)  
	local height = math.min(obj1.y+obj1.h, obj2.y+obj2.h) - math.max(obj1.y, obj2.y)  
	--We're getting the measures of the intersection rectangle here  
        
	if dir == "top" then  
		obj1.y = obj2.y+obj2.h
	elseif dir == "bottom" then  
		obj1.y = obj2.y-obj1.h 
	elseif dir == "right" then
		obj1.x = obj2.x+obj2.w
	elseif dir == "left" then  
		obj1.x = obj2.x-obj1.w
	end  
end  