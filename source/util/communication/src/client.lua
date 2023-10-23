local Remote = _G.RequireUtil("remote")
local clientComms = {}
clientComms.__index = clientComms

function clientComms.new(serverFolder:Folder)
	local self = setmetatable({}, clientComms)
	self.__server = serverFolder
	return self
end

function clientComms:buildClient()
	local client = {}
	for index, value in self.__server:GetChildren() do
		if not value:IsA("RemoteFunction") then
			pcall(function()
				client[value.Name] = value
			end)
			continue
		end
		
		local remoteFunction = Remote.new("function").newClient {remote = value}
		
		client[value.Name] = function(...)
			local args = {...}
			table.remove(args, 1)
			return remoteFunction:Server(table.unpack(args))
		end
	end
	return client
end

return clientComms
