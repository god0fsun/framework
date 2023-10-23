export type controllerDef = {
	Name:string
}

local client = {}
local controllers = {}
local services = {}

local Framework = script.Parent.Parent
local comms = require(_G.Util.communication).client()

local function getServiceRep()
	return Framework:FindFirstChild("Services")
end

function client:add(contents:Folder)
	for i, v in contents:GetChildren() do
		local content = require(v)
		if not content.Name then
			continue
		end

		controllers[content.Name] = content
	end
end

function client:create(controller:controllerDef)
	controllers[controller.Name] = controller
	return controller
end

function client:fetch(controllerName:string)
	return controllers[controllerName]
end

function client:fetchService(serviceName:string)
	local service = services[serviceName]
	
	if not service then
		local repFolder = getServiceRep()
		local serviceFolder = repFolder:FindFirstChild(serviceName)
		if serviceFolder then
			local clientComms = comms.new(serviceFolder)
			local clientTable = clientComms:buildClient()
			service = clientTable
			services[serviceName] = service
		end
	end
	
	return service
end

function client:run()
	local initalizedControllers = {}

	for index, value in controllers do
		task.spawn(function()
			if value["first"] then
				value:first()
			end

			table.insert(initalizedControllers, value)
		end)
	end

	for index, value in initalizedControllers do
		task.spawn(function()
			if value["start"] then
				value:start()
			end
		end)
	end
end

return client
