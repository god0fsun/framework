local isAncestorOfPlayer = script:FindFirstAncestorWhichIsA("Player") ~= nil

if not isAncestorOfPlayer then
	return -- Putting a script in StarterPlayerScripts may cause them to run twice
end

-- Services --
local repStorage = game:GetService("ReplicatedStorage")
local repFirst = game:GetService("ReplicatedFirst")
-- Client --
local clientStorage = repFirst:FindFirstChild("ClientServices")
local Framework = require(repStorage:FindFirstChild("framework")) -- Initalize the client (_G) table for service ease of use

-- Adding Files --
Framework.client:add(clientStorage)

-- Running Framework --
Framework.client:run()
