local Comms = {}

function Comms.client()
	return require(script.src.client)
end

function Comms.server()
	return require(script.src.server)
end

return Comms
