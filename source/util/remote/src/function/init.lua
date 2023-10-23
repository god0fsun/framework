export type settings = {
	name:string,
	parent:Instance,
	remote:RemoteFunction|nil
}

local remoteFunction = {}
remoteFunction.__index = remoteFunction
local optimizer = require(script.Parent.Parent.optimization.op)

local function compress(op, ...)
	local data = {...}
	local serialized = op:serialize(data)
	return serialized
end

local function decompress(op, ...)
	local args = ...
	if typeof(args) ~= "table" then
		args = {...}
	end
	local unserialized = op:unserialize(args)
	return unserialized
end

function remoteFunction.newClient(setting:settings)
	local remote = setting.remote or Instance.new("RemoteFunction")
	if not setting.remote then
		remote.Parent = setting.parent
		remote.Name = setting.name
	end
	return require(script.client).new(remote, optimizer.new(), compress, decompress)
end

function remoteFunction.newServer(setting:settings)
	local remote = setting.remote or Instance.new("RemoteFunction")
	if not setting.remote then
		remote.Parent = setting.parent
		remote.Name = setting.name
	end
	return require(script.server).new(remote, optimizer.new(), compress, decompress)
end

return remoteFunction
