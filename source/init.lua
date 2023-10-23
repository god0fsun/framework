_G.Util = script.util

_G.RequireUtil = function(utilName)
	return require(_G.Util:WaitForChild(utilName))
end 

_G.Framework = {
	server = require(script.src.server),
	client = require(script.src.client)
}

setmetatable(_G, {
	__index = error,
	__newindex = error,
	__metatable = "Locked",
})

return _G.Framework
