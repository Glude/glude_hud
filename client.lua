ESX = nil


-- Player Money 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    local data = xPlayer
    local accounts = data.accounts
    for k, v in pairs(accounts) do
        local account = v
        if account.money > 0 then
        end

        SendNUIMessage({
            action = "setMoney",
            money = data.money
        })
    end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if account.name == "money" then

        SendNUIMessage({
            action = "setMoney",
            money = account.money
        })
    end
end)

RegisterNetEvent('esx:activateMoney')
AddEventHandler('esx:activateMoney', function(e)
    SendNUIMessage({
        action = "setMoney",
        money = e
    })
end)

-- Pause menu entfernen

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsPauseMenuActive() and not isPaused then
            isPaused = true
            SendNUIMessage({
                action = "hideHud"
            })
        elseif not IsPauseMenuActive() and isPaused then
            isPaused = false
            SendNUIMessage({
                action = "showHud"
            })
        end
    end
end)

-- Death Player
AddEventHandler('esx:onPlayerDeath', function()
    isDead = true
    SendNUIMessage({
        action = "muted",
        muted = true
    })
    TriggerServerEvent('SaltyChat_SetVoiceRange', 0.0)
end)

-- PlayerID showHud
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SendNUIMessage({
            action = "update_status",
            pid = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
        })
    end
end)


-- CarHUD

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            -- Vehicle Speed
            if inVehicle == false then
                inVehicle = true
            end

            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
            local vehicleSpeedSource = GetEntitySpeed(vehicle)
            local LockStatus = GetVehicleDoorLockStatus(vehicle)
            local islocked = false
            local vehicleSpeed
            vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)

            -- Vehicle Fuel and Gear

            local vehicleFuel
            vehicleFuel = math.floor(GetVehicleFuelLevel(vehicle))
            local vehicleGear = GetVehicleCurrentGear(vehicle)
            local _, light = GetVehicleLightsState(vehicle)
            if (vehicleSpeed == 0 and vehicleGear == 0) then
                vehicleGear = 'N'
            elseif (vehicleSpeed == 0 and vehicleGear == 1) then
                vehicleGear = tostring(vehicleGear)
            elseif vehicleSpeed > 0 and vehicleGear == 0 then
                vehicleGear = 'R'
            end
            if LockStatus == 2 or LockStatus == 3 or LockStatus == 10 or LockStatus == 4 then
                islocked = true
            end
            if vehicleIsOn == 1 then
                vehicleIsOn = true
            end

            if lastDamage ~= GetEntityHealth(vehicle) then
                lastDamage = GetEntityHealth(vehicle)
                SendNUIMessage({
                    action = 'handleDamage',
                    data = lastDamage
                })
            end

            SendNUIMessage({
                action = 'updateHudFuel',
                data = vehicleFuel
            })
            SendNUIMessage({
                action = 'updateCarHud',
                data = {
                    speed = vehicleSpeed,
                    geer = vehicleGear
                }
            })
            SendNUIMessage({
                action = 'toggleCarHud',
                data = true
            })
            SendNUIMessage({
                action = 'handleEngine',
                data = vehicleIsOn
            })
            SendNUIMessage({
                action = 'handleBeam',
                data = light
            })
            SendNUIMessage({
                action = 'handleLock',
                data = islocked
            })
        else
            if inVehicle == true then
                inVehicle = false
                SendNUIMessage({
                    action = 'toggleCarHud',
                    data = false
                })
                SendNUIMessage({
                    action = 'handleEngine',
                    data = false
                })
                lastDamage = -1
            end

            Citizen.Wait(1000) -- Performance
        end

    end
end)