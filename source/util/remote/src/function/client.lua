local util = script.Parent.Parent.Parent.Parent
local maid = require(util.maid)
local client = {}
client.__index = client

function client.new(remote, optimizer, fnCompress, fnUncompress)
	local self = setmetatable({}, client)
	self.__remote = remote
	self.__compress = fnCompress
	self.__uncompress = fnUncompress
	self.__cleanup = maid.new()
	self.__op = optimizer
	return self
end

function client:Server(...)
	return self.__remote:InvokeServer({...})
end

function client:Connect(fn)
	local remote = function(args)
		fn(table.unpack(args))
	end
	self.__remote.OnClientInvoke = remote
end

function client:destroy()
	self.__cleanup:Destroy()
	self = nil
end

return client
