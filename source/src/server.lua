export type serviceDef = {
	Name:string,
	Client:{}
}

local server = {}
local services = {}

local Framework = script.Parent.Parent

local ss = game:GetService("ServerStorage")
local comms = require(_G.Util.communication).server()

local serviceRep = Instance.new("Folder")
serviceRep.Name = "Services"
serviceRep.Parent = game:GetService("ServerStorage")

function server:add(contents:Folder)
	for i, v in contents:GetChildren() do
		local content = require(v)
		if not content.Name then
			continue
		end
		
		services[content.Name] = content
	end
end

function server:create(service:serviceDef)
	local ServiceFolder = Instance.new("Folder")
	ServiceFolder.Parent = serviceRep
	ServiceFolder.Name = service.Name
	service.Comm = {
		Folder = ServiceFolder,
		RemoteComm = comms.new(ServiceFolder)
	}
	services[service.Name] = service
	return service
end

function server:fetch(serviceName:string)
	return services[serviceName]
end

function server:run()
	local initalizedServices = {}
	
	for index, service in services do
		for i, v in service["Client"] do
			service.Comm.RemoteComm:wrap(service["Client"], i)
		end
		
		task.spawn(function()
			if service["first"] then
				service:first()
			end
			
			table.insert(initalizedServices, service)
		end)
	end
	
	for index, service in initalizedServices do
		task.spawn(function()
			if service["start"] then
				service:start()
			end
		end)
	end
	
	serviceRep.Parent = Framework
end

return server
