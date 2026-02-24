local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "My Oil Farm " .. Fluent.Version,
    SubTitle = "by mnarchik",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "wallet" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Notification",
        Content = "Script Has Loaded",
        Duration = 5 -- Set to nil to make the notification not disappear
    })



    Tabs.Main:AddParagraph({
        Title = "Script",
        Content = "AutoCollect, Auto Rebirth, Etc."
    })



    Tabs.Main:AddButton({
        Title = "KILASIK's Fling GUI",
        Description = "Fling GUI",
        Callback = function()
            Window:Dialog({
                Title = "Execute",
                Content = "Execute",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            print("Confirmed")
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/K1LAS1K/Ultimate-Fling-GUI/main/flingscript.lua"))()
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled")
                        end
                    }
                }
            })
        end
    })
  
  
  
  Tabs.Main:AddButton({
        Title = "Noclip",
        Description = "Noclip/AntiFling",
        Callback = function()
            Window:Dialog({
                Title = "Execute",
                Content = "Execute",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            print("Confirmed")
                            local Noclip = nil
local Clip = nil

function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and game.Players.LocalPlayer.Character ~= nil then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21) -- basic optimization
    end
    Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
    if Noclip then Noclip:Disconnect() end
    Clip = true
end

noclip()
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled")
                        end
                    }
                }
            })
        end
    })
  
  
  
  Tabs.Main:AddButton({
        Title = "Auto Farm StarTank",
        Description = "Reset to stop, ServerHop Before Using.",
        Callback = function()
            Window:Dialog({
                Title = "Execute",
                Content = "Execute",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            print("Confirmed")
                            local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Configuration
local searchKeyword = "Tank"
local tweenTime = 2 
local delayBetweenTweens = nil -- How long to wait at the tank before finding the next one

local function findClosestTank(startPosition)
    local closestModel = StarTank
    local shortestDistance = math.huge

    -- Checks every model in the workspace
    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("Model") and string.find(object.Name, searchKeyword) then
            local targetPart = object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart")
            
            if targetPart then
                local distance = (startPosition - targetPart.Position).Magnitude
                if distance then
                    shortestDistance = distance
                    closestModel = object
                end
            end
        end
    end
    return closestModel
end

local function startLoopingTween()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    while true do
        local targetTank = findClosestTank(rootPart.Position)

        if targetTank then
            local targetPart = targetTank.PrimaryPart or targetTank:FindFirstChildWhichIsA("BasePart")
            
            -- Prepare Tween
            local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local goal = {CFrame = targetPart.CFrame * CFrame.new(0, 5, 0)} -- Offset 5 studs above
            
            local tween = TweenService:Create(rootPart, tweenInfo, goal)
            
            -- Play and wait for completion
            tween:Play()
            tween.Completed:Wait() 
            
            print("Reached: " .. targetTank.Name)
            task.wait(delayBetweenTweens)
        else
            -- If no tank is found, wait a bit before checking again to save performance
            task.wait(2)
        end
    end
end

-- Start the loop
task.spawn(startLoopingTween)

                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled")
                        end
                    }
                }
            })
        end
    })
  
  
  
  Tabs.Main:AddButton({
        Title = "ServerHop",
        Description = "Use Before Anything Else",
        Callback = function()
            Window:Dialog({
                Title = "Confirm",
                Content = "Confirm",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            print("Confirmed")
                            local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place = game.PlaceId
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
function ListServers(cursor)
  local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
  return Http:JSONDecode(Raw)
end

local Server, Next; repeat
  local Servers = ListServers(Next)
  Server = Servers.data[1]
  Next = Servers.nextPageCursor
until Server

TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled")
                        end
                    }
                }
            })
        end
    })



local Toggle = Tabs.Main:AddToggle("AutoRebirth", {
    Title = "Auto Rebirth", 
    Default = false 
})

Toggle:OnChanged(function()
    -- Use the current state of the toggle
    local state = Toggle.Value
    _G.RebirthActive = state
    
    print("Rebirth Loop State:", state)

    if state then
        -- We wrap the loop in a task.spawn so it doesn't "freeze" the rest of the script
        task.spawn(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local rebirthRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RebirthRequest")

            while _G.RebirthActive do
                rebirthRemote:FireServer()
                task.wait(1) -- Adjust this delay as needed
            end
            print("Rebirth Loop: STOPPED")
        end)
    end
end)

-- Setting the initial value if needed
Toggle:SetValue(false)
end


  
-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
