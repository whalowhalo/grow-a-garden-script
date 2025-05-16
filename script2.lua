getgenv().autoBuy = true
getgenv().autoPlant = true
getgenv().autoWater = true
getgenv().autoHarvest = true
getgenv().autoSell = true
getgenv().autoCollectMoonlit = true

local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("Events")

function buyItems()
    while getgenv().autoBuy do
        events.BuyItem:FireServer("Seeds")
        events.BuyItem:FireServer("Eggs")
        events.BuyItem:FireServer("Gear")
        wait(5)
    end
end

function plantLoop()
    while getgenv().autoPlant do
        for _, plot in pairs(workspace.Plots:GetChildren()) do
            events.Plant:FireServer(plot)
        end
        wait(2)
    end
end

function waterLoop()
    while getgenv().autoWater do
        for _, plot in pairs(workspace.Plots:GetChildren()) do
            if plot:FindFirstChild("NeedsWater") then
                events.Water:FireServer(plot)
            end
        end
        wait(2)
    end
end

function harvestLoop()
    while getgenv().autoHarvest do
        for _, plot in pairs(workspace.Plots:GetChildren()) do
            if plot:FindFirstChild("ReadyToHarvest") then
                events.Harvest:FireServer(plot)
            end
        end
        wait(2)
    end
end

function sellLoop()
    while getgenv().autoSell do
        events.Sell:FireServer()
        wait(5)
    end
end

function moonlitLoop()
    while getgenv().autoCollectMoonlit do
        for _, plant in pairs(workspace:GetDescendants()) do
            if plant:IsA("Model") and plant.Name:find("Moonlit") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plant.PrimaryPart.CFrame
                wait(0.5)
                events.Collect:FireServer(plant)
            end
        end
        wait(10)
    end
end

spawn(buyItems)
spawn(plantLoop)
spawn(waterLoop)
spawn(harvestLoop)
spawn(sellLoop)
spawn(moonlitLoop)
