local test = _G.Framework.client:create {Name = "Hi"}

function test:first()
	print("initalized")
end

function test:start()
	print("started!")
	
	local testService = _G.Framework.client:fetchService("Hi")
	testService:TestFunction()
	testService:TestFunction("Hi!!!")
end

return test
