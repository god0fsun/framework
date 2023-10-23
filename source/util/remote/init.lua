local Remote = {}
Remote.__index = Remote

function Remote.new(remoteType:string)
	if not remoteType then
		error("no remoteType")
	end
	
	local remoteModule = nil
	
	local success, fail = pcall(function()
		remoteModule = require(script.src:FindFirstChild(remoteType))
	end)
	
	if fail then
		error(`no such remote called {remoteType}`)
	else
		return remoteModule
	end
end

return Remote
