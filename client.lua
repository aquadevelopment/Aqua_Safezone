local inSafeZone = false
local currentSafeZone = nil
local isSpeedLimited = false

function IsPlayerInSafeZone()
    local playerCoords = GetEntityCoords(PlayerPedId())

    for i, zone in ipairs(Config.SafeZones) do
        local distance = #(playerCoords - vector3(zone.coords.x, zone.coords.y, zone.coords.z))
        if distance <= zone.radius then
            return true, i
        end
    end

    return false, nil
end

function DrawSafeZoneSphere(zone)

    DrawMarker(28, zone.coords.x, zone.coords.y, zone.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, zone.radius, zone.radius, zone.radius, zone.color.r, zone.color.g, zone.color.b, zone.color.a, false, false, 2, false, nil, nil, false)
end

function DisableBlacklistedKeys()
    for _, key in ipairs(Config.BlacklistedKeys) do
        DisableControlAction(0, key, true)
    end
end

function ShowNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, true)
end

function LimitVehicleSpeed()
    local playerPed = PlayerPedId()
    
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local speed = GetEntitySpeed(vehicle) * 3.6 

        if speed > Config.MaxVehicleSpeed then
            SetVehicleForwardSpeed(vehicle, Config.MaxVehicleSpeed / 3.6)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local isInZone, zoneIndex = IsPlayerInSafeZone()

        if isInZone and not inSafeZone then
            inSafeZone = true
            currentSafeZone = zoneIndex

            if Config.EnableGodMode then
                NetworkSetFriendlyFireOption(false) 
            end

            ShowNotification(Config.Messages.enterSafeZone)
            ShowNotification(Config.Messages.speedLimit)
            
            isSpeedLimited = true

        elseif not isInZone and inSafeZone then
            inSafeZone = false
            currentSafeZone = nil

            NetworkSetFriendlyFireOption(true) 

            ShowNotification(Config.Messages.exitSafeZone)
            
            isSpeedLimited = false
        end

        for i, zone in ipairs(Config.SafeZones) do
            DrawSafeZoneSphere(zone) 
        end

        if inSafeZone then
            DisableBlacklistedKeys()
        end

        if isSpeedLimited then
            LimitVehicleSpeed()
        end
    end
end)