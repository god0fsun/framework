local maid = _G.RequireUtil("maid")
local server = {}
server.__index = server
local runService = game:GetService("RunService")

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
	local args = {...}
	local success, fail = pcall(function()
		self.__remote:FireClient(Client, args)
	end)

	if fail then
		warn(`Failed to send to {Client.Name}`)
	end
end

function server:Clients(Clients:{[any]:Player}, ...)
	local args = {...}
	task.spawn(function()
		for index, value in Clients do

			task.spawn(function()
				local success, fail = pcall(function()
					self.__remote:FireClient(value, args)
				end)

				if fail then
					warn(`Failed to send to {value.Name}`)
				end
			end)

		end
	end)
end

function server:All(...)
	self.__remote:FireAllClients({...})
end

function server:Connect(fn)
	local remote = self.__remote.OnServerEvent:Connect(function(plr, args)
		fn(plr, table.unpack(args))
	end)
	self.__cleanup:Add(remote)
	return remote
end

function server:destroy()
	self.__cleanup:Destroy()
	self = nil
end

return server
