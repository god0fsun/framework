-- Services --
local repStorage = game:GetService("ReplicatedStorage")
local serverStorage = game:GetService("ServerStorage")
-- Client --
local serverStorage = serverStorage:FindFirstChild("ServerServices")
local Framework = require(repStorage:FindFirstChild("framework")) -- Initalize the server (_G) table for service ease of use

-- Adding Files --
Framework.server:add(serverStorage)

-- Running Framework --
Framework.server:run()
