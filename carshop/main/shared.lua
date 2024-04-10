Config = {}

Config.SellVehicles = {
    vector3(-45.0163, -1083.18, 26.708)
}

Config.RefundPercent = 50 -- 70% (percentage from original value)
Config.Framework = "QBCore" -- QBCore or ESX or OLDQBCore -- NewESX

function GetFramework()
    local Get = nil
    if Config.Framework == "ESX" then
        while Get == nil do
            TriggerEvent('esx:getSharedObject', function(Set) Get = Set end)
            Citizen.Wait(0)
        end
    end
    if Config.Framework == "NewESX" then
        Get = exports['es_extended']:getSharedObject()
    end
    if Config.Framework == "QBCore" then
        Get = exports["qb-core"]:GetCoreObject()
    end
    if Config.Framework == "OldQBCore" then
        while Get == nil do
            TriggerEvent('QBCore:GetObject', function(Set) Get = Set end)
            Citizen.Wait(200)
        end
    end
    return Get
 end

Config.Vehicles = {
    Car = {
        ['car'] = {
            {model='brioso3',       label='Brioso 300',         price=9000,     category='Compacts'},
            {model='weevil',        label='Weevil',             price=9000,     category='Compacts'},
            {model='kanjo',         label='Kanjo',              price=10200,    category='Compacts'},
            {model='issi2',         label='Issi',               price=9000,     category='Compacts'},
            {model='previon',       label='Previon',            price=11000,    category='Compacts'},
            {model='windsor2',      label='Windsor drop',       price=18000,    category='Compacts'},
            {model='exemplar',      label='Exemplar',           price=22000,    category='Compacts'},        
            {model='sentinel',      label='Sentinel',           price=23000,    category='Compacts'},
            {model='kanjosj',       label='Kanjo sj',           price=25000,    category='Compacts'},
            {model='dominator8',    label='Dominator GTT',      price=30000,    category='Muscle'},
            {model='dominator7',    label='Dominator ASP',      price=35000,    category='Muscle'},
            {model='yosemite',      label='Yosemite',           price=33000,    category='Muscle'},
            {model='virgo2',        label='Virgo Custom',       price=29000,    category='Muscle'},
            {model='chino2',        label='Chino Deluxe',       price=29000,    category='Muscle'},
            {model='primo2',        label='Primo Custom',       price=9000,     category='Sedans'},
            {model='cinquemila',    label='Cinquemila',         price=24000,    category='Sedans'},
            {model='impaler6',      label='Impaler LX',         price=923000,   category='Sedans'},
            {model='vivanite',      label='Vivanite',           price=92300,    category='SUVs'},
            {model='astron',        label='Astron Custom',      price=19000,    category='SUVs'},
            {model='baller7',       label='Baller ST',          price=3600,     category='SUVs'},
            {model='contender',     label='Contender',          price=13000,    category='SUVs'},
            {model='l35',           label='Walton L35',         price=23000,    category='Off-Road'},
            {model='caracara2',     label='caracara 4x4',       price=30000,    category='Off-Road'},
            {model='kalahari',      label='Kalahari',           price=1000,     category='Off-Road'},
            {model='minivan2',      label='Minivan Custom',     price=3000,     category='Vans'},
            {model='youga3',        label='Youga 4x4',          price=7000,     category='Vans'},
            {model='speedo5',       label='Speedo',             price=8600,     category='Vans'},
            {model='surfer3',       label='surfer',             price=3000,     category='Vans'},
            {model='r300',          label='300r',               price=30000,    category='Sports'},
            {model='tenf2',         label='10F widebody',       price=63000,    category='Sports'},
            {model='sultanrs',      label='Sultan RS',          price=6000,     category='Sports'},
            {model='vectre',        label='Vectre',             price=6300,     category='Sports'},
            {model='rt3000',        label='Rt3000',             price=4600,     category='Sports'},
            {model='Euros',         label='Euros',              price=6700,     category='Sports'},
            {model='Growler',       label='Growler',            price=923000,   category='Sports'},
            {model='coquette4',     label='Coquette D10',       price=80000,    category='Sports'},
            {model='sugoi',         label='Sugoi',              price=23000,    category='Sports'},
            {model='komoda',        label='Komoda',             price=25000,    category='Sports'},
            {model='Neon',          label='Neon',               price=120000,   category='Sports'},
            {model='Kuruma',        label='Kuruma',             price=23000,    category='Sports'},
            {model='Feltzer2',      label='Feltzer',            price=12000,    category='Sports'},
            {model='elegy2',        label='Elegy RH8',          price=15000,    category='Sports'},
            {model='Jugular',       label='Jugular',            price=50000,    category='Sports'},
            {model='Virtue',        label='Virtue',             price=120000,   category='Sports Classics'},
            {model='entity2',       label='Entity MT',          price=92000,    category='Sports Classics'},
            {model='Cyclone',       label='Cyclone',            price=120000,   category='Sports Classics'},
            {model='Champion',      label='Champion',           price=70000,    category='Sports Classics'},
            {model='Thrax',         label='Thrax',              price=250000,   category='Sports Classics'},
            {model='Xa21',          label='Xa-21',              price=230000,   category='Sports Classics'},
            {model='Tempesta',      label='Tempesta',           price=190000,   category='Sports Classics'},
            {model='T20',           label='T20',                price=923000,   category='Sports Classics'},
            {model='Zentorno',      label='Zentorno',           price=923000,   category='Sports Classics'},
            {model='TurismoR',      label='TurismoR',           price=923000,   category='Sports Classics'},
            {model='Vacca',         label='Vacca',              price=923000,   category='Sports Classics'},
            {model='Cheetah',       label='Cheetah',            price=923000,   category='Sports Classics'},
            {model='Vortex',        label='Vortex',             price=923000,   category='Motorcycles'},
            {model='Daemon',        label='Daemon',             price=923000,   category='Motorcycles'},
            {model='faggio2',       label='Faggio',             price=923000,   category='Motorcycles'},
            {model='Hakuchou',      label='Hakuchou',           price=923000,   category='Motorcycles'},
            {model='BF400',         label='BF400',              price=923000,   category='Motorcycles'},
            {model='Sanches2',      label='Sanches2',           price=923000,   category='Motorcycles'},
            {model='double',        label='Double-T',           price=923000,   category='Motorcycles'},
            {model='bati',          label='Bati801',            price=923000,   category='Motorcycles'},
        },

        ['boat'] = {
          {model='Seashark2',       label='Seashark',          price=1600,    category='boats'},
          {model='Seashark3',       label='Seashark3',         price=2600,    category='criminals'},
          {model='Submersible2',    label='Submersible2',      price=3600,    category='boats'},
          {model='Dinghy4',         label='Dinghy4',           price=5600,    category='boats'},
          {model='Dinghy',          label='Dinghy',            price=6600,    category='boats'},
          {model='Toro',            label='Toro',              price=6600,    category='boats'},
        },

        ['aircraft'] = {
          {model='Cargobob',        label='Cargobob',          price=1600,    category='military'},
          {model='Maverick',        label='Maverick',          price=3600,    category='military'},
          {model='Valkyrie2',       label='Valkyrie2',         price=3600,    category='airplane'},
          {model='Swift2',          label='Swift2',            price=5600,    category='airplane'},
        },


        ['armor'] = {
            {model='police',     label='Police',          price=1600,    category='armor'},
            {model='police2',    label='Police 2',        price=2600,    category='armor'},
            {model='police3',    label='Police 3',        price=3600,    category='armor'},
        },

    },    

    Category = {
        ['car'] = {
            {name="Compacts",    trunk='25'},
            {name='Muscle',      trunk='50'},
            {name='Sedans',     trunk='7.5'},
            {name='SUVs',     trunk='7.5'},
            {name='Off-Road',     trunk='75'},
            {name='Vans',     trunk='75'},
            {name='Sports',     trunk='75'},
            {name='Sports Classics',     trunk='5'},
            {name='Motorcycles', trunk='5'},
        },
        ['addons'] = {
            {name="Compacts",    trunk='25'},
            {name='Muscle',      trunk='50'},
            {name='Sedans',     trunk='7.5'},
            {name='SUVs',     trunk='7.5'},
            {name='Off-Road',     trunk='75'},
            {name='Vans',     trunk='75'},
            {name='Sports',     trunk='75'},
            {name='Sports Classics',     trunk='5'},
            {name='Motorcycles', trunk='5'},
        },

        ['boat'] = {
            {name="boats",     trunk='15'},
            {name='criminals', trunk='25'},
        },

        ['aircraft'] = {
            {name="military", trunk='125'},
            {name="airplane", trunk='175'},
        },

        ['armor'] = {
            {name="armor", trunk='125'},
        }



    },

    Color = {
        ['car'] = {
            {R = 132, G = 131, B = 145},
            {R = 141, G = 82 , B = 38},
            {R = 142, G = 148, B = 36},
            {R = 104, G = 146, B = 36},
            {R = 139, G = 80 , B = 24},
            {R = 32 , G = 87 , B = 15},
            {R = 24 , G = 144, B = 10},
            {R = 40 , G = 143, B = 34},
            {R = 130, G = 18 , B = 22},
            {R = 135, G = 35 , B = 39},
            {R = 121, G = 19 , B = 14},
            {R = 4,   G = 32 , B = 14},
            {R = 35 , G = 35 , B = 45},
            {R = 89 , G = 25 , B = 47},
            {R = 64 , G = 62 , B = 23},
            {R = 38 , G = 46 , B = 19},
        },

        ['boat'] = {
            {R = 132, G = 131, B = 145},
            {R = 141, G = 82 , B = 38},
            {R = 142, G = 148, B = 36},
            {R = 104, G = 146, B = 36},
            {R = 139, G = 80 , B = 24},
            {R = 32 , G = 87 , B = 15},
            {R = 24 , G = 144, B = 10},
            {R = 40 , G = 143, B = 34},
            {R = 130, G = 18 , B = 22},
            {R = 135, G = 35 , B = 39},
            {R = 121, G = 19 , B = 14},
            {R = 4,   G = 32 , B = 14},
            {R = 35 , G = 35 , B = 45},
            {R = 89 , G = 25 , B = 47},
            {R = 64 , G = 62 , B = 23},
            {R = 38 , G = 46 , B = 19},   
        },

        ['aircraft'] = {
            {R = 132, G = 131, B = 145},
            {R = 141, G = 82 , B = 38},
            {R = 142, G = 148, B = 36},
            {R = 104, G = 146, B = 36},
            {R = 139, G = 80 , B = 24},
            {R = 32 , G = 87 , B = 15},
            {R = 24 , G = 144, B = 10},
            {R = 40 , G = 143, B = 34},
            {R = 130, G = 18 , B = 22},
            {R = 135, G = 35 , B = 39},
            {R = 121, G = 19 , B = 14},
            {R = 4,   G = 32 , B = 14},
            {R = 35 , G = 35 , B = 45},
            {R = 89 , G = 25 , B = 47},
            {R = 64 , G = 62 , B = 23},
            {R = 38 , G = 46 , B = 19},   
        },

        ['armor'] = {
            {R = 132, G = 131, B = 145},
            {R = 141, G = 82 , B = 38},
            {R = 142, G = 148, B = 36},
            {R = 104, G = 146, B = 36},
            {R = 139, G = 80 , B = 24},
            {R = 32 , G = 87 , B = 15},
            {R = 24 , G = 144, B = 10},
            {R = 40 , G = 143, B = 34},
            {R = 130, G = 18 , B = 22},
            {R = 135, G = 35 , B = 39},
            {R = 121, G = 19 , B = 14},
            {R = 4,   G = 32 , B = 14},
            {R = 35 , G = 35 , B = 45},
            {R = 89 , G = 25 , B = 47},
            {R = 64 , G = 62 , B = 23},
            {R = 38 , G = 46 , B = 19},   
        }
    }
}



CustomizeCamera = function(self)
    isOpen = not self
    DisplayHud(isOpen)
    DisplayRadar(isOpen)
end

Config.GetVehFuel = function(Veh)
    return GetVehicleFuelLevel(Veh)-- exports["LegacyFuel"]:GetFuel(Veh)
end

Config.Carkeys = function(Plate)
    TriggerEvent('vehiclekeys:client:SetOwner', Plate)
end

CustomizePlate = function()
    return string.upper(randomNumber(2) .. randomCharacter(3) .. randomNumber(3))
end

Config.Locations = {
    { 
        job = 'police', -- job 
        type = 'armor', -- car type
        coords = vector3(440.72, -1013.17, 27.62),
        hash = "a_m_o_soucent_01",
        heading = 162.28,
        marker = "POLICE SHOP",
        blip = {
            ["active"] = true,
            ["name"] = "Police Car Shop",
            ["colour"] = 4,
            ["id"] = 56
        },
        NuiCarViewSpawnPosition = vector4(-73.5, -822.0, 284.8, 201.5),
        NuiCarViewCameraPosition = {
            posX = -67.0,
            posY = -824.5,
            posZ = 285.5,
            rotX = -9.0,
            rotY = 0,
            rotZ = 74.0,
            fov = 45.00
        },
        TestDriveTime = 60,
        TestDriveSpawnPosition = vector4(-874.34, -3226.6, 13.22, 60.82),
        BuyCarSpawnPositions = {
            [1] = vector4(442.87, -1025.9, 27.71, 3.56),
            [2] = vector4(438.57, -1025.83, 27.78, 352.31),
            [3] = vector4(435.38, -1026.68, 27.84, 347.11),
            [4] = vector4(431.69, -1027.0, 27.91, 345.23),
            [5] = vector4(427.41, -1027.12, 27.99, 346.04)
        },
    }, 

    
    { 
        job = 'all', -- job
        type = 'car',
        coords = vector3(-56.74, -1096.68, 25.42),
        hash = "a_m_o_soucent_01",
        heading = 26.2,
        marker = "Nacionales",
        blip = {
            ["active"] = true,
            ["name"] = "Car Shop",
            ["colour"] = 4,
            ["id"] = 56
        },
        NuiCarViewSpawnPosition = vector4(-73.5, -822.0, 284.8, 201.5),
        NuiCarViewCameraPosition = {
            posX = -67.0,
            posY = -824.5,
            posZ = 285.5,
            rotX = -9.0,
            rotY = 0,
            rotZ = 74.0,
            fov = 45.00
        },
        TestDriveTime = 60,
        TestDriveSpawnPosition = vector4(-874.34, -3226.6, 13.22, 60.82),
        BuyCarSpawnPositions = {
            [1] = vector4(-10.6716, -1096.76, 26.183, 100.5),
            [2] = vector4(-11.4883, -1099.59, 26.180, 100.5),
            [3] = vector4(-12.4124, -1102.35, 26.183, 100.5),
            [4] = vector4(-13.0040, -1105.23, 26.179, 100.5),
            [5] = vector4(-14.5665, -1108.37, 26.183, 100.5)
        },
    }, 

    
    { 
        job = 'all', -- job
        type = 'addons',
        coords = vector3(-50.7615, -1089.2360, 26.4224),
        hash = "a_m_o_soucent_01",
        heading = 117.6896,
        marker = "Importados",
        blip = {
            ["active"] = false,
            ["name"] = "Car Shop Addons",
            ["colour"] = 4,
            ["id"] = 56
        },
        NuiCarViewSpawnPosition = vector4(-73.5, -822.0, 284.8, 201.5),
        NuiCarViewCameraPosition = {
            posX = -67.0,
            posY = -824.5,
            posZ = 285.5,
            rotX = -9.0,
            rotY = 0,
            rotZ = 74.0,
            fov = 45.00
        },
        TestDriveTime = 60,
        TestDriveSpawnPosition = vector4(-874.34, -3226.6, 13.22, 60.82),
        BuyCarSpawnPositions = {
            [1] = vector4(-10.6716, -1096.76, 26.183, 100.5),
            [2] = vector4(-11.4883, -1099.59, 26.180, 100.5),
            [3] = vector4(-12.4124, -1102.35, 26.183, 100.5),
            [4] = vector4(-13.0040, -1105.23, 26.179, 100.5),
            [5] = vector4(-14.5665, -1108.37, 26.183, 100.5)
        },
    },

    { 
        job = 'all', -- job
        type = 'boat',
        coords = vector3(-706.262, -1360.31, 4.1021),
        hash = "a_m_o_soucent_01",
        heading = 170.00,
        marker = "BOAT SHOP",
        blip = {
            ["active"] = true,
            ["name"] = "Boat Shop",
            ["colour"] = 4,
            ["id"] = 427
        },
        NuiCarViewSpawnPosition = vector4(-716.794, -1344.95, 0.1710, 201.5),
        NuiCarViewCameraPosition = {
            posX = -725.602, -- -725.602, -1358.61, 0.1185
            posY = -1358.61,
            posZ = 7.0,
            rotX = -16.0,
            rotY = 0,
            rotZ = -35.0,
            fov = 45.00
        },
        TestDriveTime = 60,
        TestDriveSpawnPosition = vector4(-912.642, -1455.92, 0.1226, 60.82),
        BuyCarSpawnPositions = {
            [1] = vector4(-748.3, -1356.2, 1.13, 231.02),
            [2] = vector4(-754.52, -1361.99, 0.42, 231.65)

        },
    }, 

    { 
        job = 'all', -- job
        type = 'aircraft',
        coords = vector3(1729.02, 3293.57, 40.19),
        hash = "a_m_o_soucent_01",
        heading = 216.16,
        marker = "Aircraft SHOP",
        blip = {
            ["active"] = true,
            ["name"] = "Aircraft Shop",
            ["colour"] = 4,
            ["id"] = 64
        },
        NuiCarViewSpawnPosition = vector4(-75.3122, -818.490, 326.17, 201.5),
        NuiCarViewCameraPosition = {
            posX = -52.1,
            posY = -825.4,
            posZ = 335.17,
            rotX = -20.0,
            rotY = 0,
            rotZ = 73.2,
            fov = 40.00
        },
        TestDriveTime = 60,
        TestDriveSpawnPosition = vector4(-874.34, -3230.6, 13.22, 60.82),
        BuyCarSpawnPositions = {
            [1] = vector4(1696.33, 3248.07, 39.92, 284.66),
            [2] = vector4(1668.62, 3241.17, 39.66, 284.33)
           
        },
    }, 

}


EYES = {}
EYES.Functions = {
    CreateBlips = function()
        for k,v in pairs(Config.Locations) do 
            if v.blip["active"] then 
            local blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, v.blip["id"])
            SetBlipScale(blip, 0.5)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, v.blip["colour"])
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blip["name"])
            EndTextCommandSetBlipName(blip)
            end
        end
    end
}







