Config = {}


Config.SafeZones = {
    {
        name = "Observatorium",
        coords = {x = -425.5866, y = 1123.4211, z = 325.8544},
        radius = 30.0,
        color = {r = 255, g = 0, b = 0, a = 150} 
    },
    {
        name = "Army",
        coords = {x = -2253.9822, y = 3250.2998, z = 32.8070}, 
        radius = 30.0,
        color = {r = 255, g = 0, b = 0, a = 150}
    },
    {
        name = "MD", 
        coords = {x = 290.2886, y = -585.3391, z = 43.1687}, 
        radius = 30.0,
        color = {r = 255, g = 0, b = 0, a = 150} 
    }
}

Config.EnableGodMode = true

Config.MaxVehicleSpeed = 30.0 

Config.BlacklistedKeys = {
    24,  
    25,  
    47, 
    58, 
    69, 
    92, 
    140, 
    141, 
    142, 
    257, 
    263, 
    264, 
    331  
}

Config.Messages = {
    enterSafeZone = "Du hast eine Safezone betreten. Waffen sind deaktiviert.",
    exitSafeZone = "Du hast die Safezone verlassen. Waffen sind wieder aktiviert.",
    speedLimit = "Geschwindigkeitslimit: 30 km/h"
}