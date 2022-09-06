ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

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

-- CARHUD
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local factor = 3, 6
        if (IsPedInAnyVehicle(ped)) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle and GetPedInVehicleSeat(vehicle, -1) == ped then
                carSpeed = math.ceil(GetEntitySpeed(vehicle) * factor)
                carRPM = GetVehicleCurrentRpm(vehicle)
                SendNUIMessage({
                    displayhud = true,
                    speed = carSpeed,
                    RPM = carRPM,
                    KMH = KPH
                })
            else
                SendNUIMessage({
                    displayhud = false
                })
                Citizen.Wait(1000)
            end
        else
            SendNUIMessage({
                displayhud = false
            })
            Citizen.Wait(100)
        end
        Citizen.Wait(1)
    end
end)

-- Straße und Ort anzeigen

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(ped))
        local city = GetLabelText(GetNameOfZone(x, y, z))
        local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(x, y, z))

        local gpsheader = streetName
        local gpsbody = city

        SendNUIMessage({
            action = "gpsheader",
            body = "gpsbody",
            gpsheader = gpsheader,
            gpsbody = gpsbody
        })
    end
    Citizen.Wait(500)
end)

