local util = script.Parent.Parent.Parent.Parent
local maid = require(util.maid)
local server = {}
server.__index = server


function server.new(remote, optimizer, fnCompress, fnUncompress)
	local self = setmetatable({}, server)
	self.__remote = remote
	self.__compress = fnCompress
	self.__uncompress = fnUncompress
	self.__cleanup = maid.new()
	self.__op = optimizer
	return self
end

function server:Client(Client:Player, ...)
	local data = {}
	local args = {...}
	local success, fail = pcall(function()
		data = {self.__remote:InvokeClient(Client, args)}
	end)

	if fail then
		warn(`Failed to send to {Client.Name} {fail}`)
	else
		return table.unpack(data)
	end
end

function server:Clients(Clients:{[any]:Player}, ...)
	local args = {...}
	local data = {}
	task.spawn(function()
		for index, value in Clients do
			task.spawn(function()
				local data = server:Client(value, args)
				data[value.Name] = data
			end)
		end
	end)
	return data
end

function server:All(...)
	server:Clients({game:GetService("Players"):GetPlayers()}, ...)
end

function server:Connect(fn)
	local connectFunction = function(plr, args)
		return fn(plr, args)
	end
	self.__remote.OnServerInvoke = connectFunction
end

function server:destroy()
	self.__cleanup:Destroy()
	self = nil
end

return server
