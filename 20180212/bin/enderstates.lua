require "love.filesystem"
enderStates = {}
enderStates.state = {}
enderStates.statePath = "/bin/gamestates/"

function enderStates.Initialize()
	local dir = enderStates.statePath
	local states = love.filesystem.getDirectoryItems(dir)

	for k, ents in ipairs(states) do
		trim = string.gsub(ents, ".lua", "")
		require(dir .. trim)
	end
end

function enderStates.LoadState(state)
	if(enderStates.state.clear)then
		enderStates.state.clear()
	end
	enderStates.state = state
	enderStates.state.Load()
end

function enderStates.Update(dt)
	enderStates.state.Update(dt)
end

function enderStates.Draw()
	enderStates.state.Draw()
end

function enderStates.KeyPressed(key, scancode, isrepeat)
	enderStates.state.KeyPressed(key, scancode, isrepeat)
end

function enderStates.KeyReleased(key, scancode)
	enderStates.state.KeyReleased(key, scancode)
end

function enderStates.TextInput(t)
	if (enderStates.state.TextInput) then
		enderStates.state.TextInput(t)
	end
end

function enderStates.MousePressed(x, y, button, istouch)
	enderStates.state.MousePressed(x, y, button, istouch)
end

function enderStates.MouseReleased(x, y, button, istouch)
	enderStates.state.MouseReleased(x, y, button, istouch)
end