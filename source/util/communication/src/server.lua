local Remote = _G.RequireUtil("remote")
local serverComms = {}
serverComms.__index = serverComms

local propertyValues = {
	["number"] = "NumberValue",
	["Vector3"] = "Vector3Value",
	["Instance"] = "ObjectValue",
	["CFrame"] = "CFrameValue",
	["string"] = "StringValue",
	["Color3"] = "Color3Value",
}

function serverComms.new(serverFolder:Folder)
	local self = setmetatable({}, serverComms)
	self.__server = serverFolder
	return self
end

function serverComms:wrap(tbl, Name)
	if self.__server:FindFirstChild(Name) then
		return
	end
	
	local obj = tbl[Name]
	
	local propertyFolder = self.__server:FindFirstChild("Properties")
	
	if typeof(obj) ~= "function" then
		if not propertyFolder then
			propertyFolder = Instance.new("Folder")
			propertyFolder.Parent = self.__server
			propertyFolder.Name = "Properties"
		end
		
		task.spawn(function()
			pcall(function()
				local instance = Instance.new(propertyValues[typeof(obj)])
				instance.Parent = propertyFolder
				instance.Name = Name
				instance.Value = obj
			end)
		end)
	else
		local remoteFunction = Remote.new("function").newServer {name = Name}
		
		remoteFunction.__remote.Parent = self.__server

		remoteFunction:Connect(function(Player, ...)
			local fnReturn = obj(nil, Player, ...) -- Due to some weird problem, the first argument is always ignored
			return fnReturn
		end)
	end
end

return serverComms
