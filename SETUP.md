Setup for the framework is fairly easy, and all found in the main repository (service/controller code is found in the service_test folder, and initalization code is found in the init_script_test folder

# Creating folders
To create services, your going to need 2 folders, **one for the server and one for the client**.
### Keep in mind that folder names and where you put them do not matter, as long as they can be accessible. But make sure to put the server folder somewhere like ServerStorage or ServerScriptService so that the client may not access them
![Screenshot 2023-10-23 173721](https://github.com/god0fsun/framework/assets/148584425/81e0e4a2-274f-4cea-8f48-6c258332f079)
![image](https://github.com/god0fsun/framework/assets/148584425/0f9bae86-2788-4db6-84c3-1a9b194e8691)

# Creating scripts
To start the framework, you'll need to initalize the clientside and the serverside of the framework, I recommend putting the server script in ServerScriptService and the client script in StarterPlayerScripts. </br>
![image](https://github.com/god0fsun/framework/assets/148584425/19771d84-104c-48fb-bd1e-b3fe53ad6d63)
![image](https://github.com/god0fsun/framework/assets/148584425/0abbd0aa-0bfe-4b5e-863f-5bf97e49a253)

### Now to write the code necessary to run the framework.
<pre><code>
  -- # Server.lua (ServerScriptService)

  -- Services --
local repStorage = game:GetService("ReplicatedStorage")
local serverStorage = game:GetService("ServerStorage") -- You may also change the service, if you didnt put your service folder in ServerStorage
-- Client --
local serverStorage = path.to.serviceFolder
local Framework = require(repStorage:FindFirstChild("framework")) -- Initalize the server (_G) table for service ease of use

-- Adding Files --
Framework.server:add(serverStorage) -- Adds all children that are modules

-- Running Framework --
Framework.server:run()
</code></pre>

<pre><code>
  -- # Client.lua (StarterPlayerScripts)
local isAncestorOfPlayer = script:FindFirstAncestorWhichIsA("Player") ~= nil

if not isAncestorOfPlayer then
	return -- Putting a script in StarterPlayerScripts may cause them to run twice, so this is necessary
end

-- Services --
local repStorage = game:GetService("ReplicatedStorage")
local repFirst = game:GetService("ReplicatedFirst") -- You may also change the service, if you didnt put your controllers folder in ReplicatedFirst
-- Client --
local clientStorage = path.to.controllers
local Framework = require(repStorage:FindFirstChild("framework")) -- Initalize the client (_G) table for service ease of use

-- Adding Files --
Framework.client:add(clientStorage)

-- Running Framework --
Framework.client:run()
</code></pre>

# Service/Controller creation wip
