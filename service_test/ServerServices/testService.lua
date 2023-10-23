local test = _G.Framework.server:create {Name = "Hi", Client = {}}

function test.Client:TestFunction(...)
	print(...)
	print(`{"no args provided!" or ...}`)
end

function test:first()
	print("initalized")
end

function test:start()
	print("started!")
end

return test
