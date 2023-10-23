export type settings = {
	name:string|nil,
	parent:Instance|nil,
	remote:RemoteEvent|nil
}

local remoteEvent = {}
remoteEvent.__index = remoteEvent
local optimizer = require(script.Parent.Parent.optimization.op)

local function compress(op, ...)
	--local data = {...}
	--local serialized = op:serialize(data)
	--return serialized
	return {...}
end

local function decompress(op, ...)
	--local args = ...
	--if typeof(args) ~= "table" then
	--	args = {...}
	--end
	--local unserialized = op:unserialize(args)
	--return unserialized
	return table.unpack(...)
end

function remoteEvent.newClient(setting:settings)
	local remote = setting.remote or Instance.new("RemoteEvent")
	if not setting.remote then
		remote.Parent = setting.parent
		remote.Name = setting.name
	end
	return require(script.client).new(remote, optimizer.new(), compress, decompress)
end

function remoteEvent.newServer(setting:settings)
	local remote = setting.remote or Instance.new("RemoteEvent")
	if not setting.remote then
		remote.Parent = setting.parent
		remote.Name = setting.name
	end
	return require(script.server).new(remote, optimizer.new(), compress, decompress)
end

return remoteEvent
