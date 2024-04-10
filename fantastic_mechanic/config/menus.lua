Config = Config or {}

Config.Menus = {
    ['empty'] = {
        title = '',
        options = {},
    },
    ['main'] = {
        title = '',
        options = {
            {label = 'Reparar', img = 'img/icons/repair.png', price = 0, onSelect = function() repairtVehicle(customVehicle) end},
            {label = 'Estetica', img = 'img/icons/visual.png', openSubMenu = 'visual'},
            {label = 'Rendimiento', img = 'img/icons/upgrade.png', openSubMenu = 'upgrade'}
        },
        onBack = function() closeUI(1) end,
        defaultOption = 1
    },
        ['upgrade'] = {
            title = 'Rendimiento',
            options = {
                {label = 'Motor', img = 'img/icons/engine.png', modType = 11, priceMult = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                {label = 'Freno', img = 'img/icons/brakes.png', modType = 12, priceMult = {0.0, 0.0, 0.0, 0.0, 0.0}},
                {label = 'Trasmisión ', img = 'img/icons/transmission.png', modType = 13, priceMult = {0.0, 0.0, 0.0, 0.0, 0.0}},
                {label = 'Suspensión', img = 'img/icons/suspension.png', modType = 15, priceMult = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                {label = 'Chasis', img = 'img/icons/armor.png', modType = 16, priceMult = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                {label = 'Turbo', img = 'img/icons/engine.png', modType = 18, priceMult = {0.0, 0.0}},
            },
            onBack = function() updateMenu('main') end
        },
        ['visual'] = {
            title = 'Estetica',
            options = {
                {label = 'Body Kit', img = 'img/icons/body.png', openSubMenu = 'body_parts'},
                {label = 'Kit interior', img = 'img/icons/body.png', openSubMenu = 'inside_parts'},
                {label = 'Pintura', img = 'img/icons/respray.png', openSubMenu = 'respray'},
                {label = 'Ruedas', img = 'img/icons/wheel.png', openSubMenu = 'wheels', onSelect = function()
                    moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'wheel_lf', {x = -1.8, y = 0.0, z = 0.0}, {x = 0.0, y = 0.0, z = -20.0})
                end},
                {label = 'Placa', img = 'img/icons/plate.png', openSubMenu = 'plate'},
                {label = 'Luces', img = 'img/icons/headlights.png', openSubMenu = 'lights'},
                {label = 'Stickers', img = 'img/icons/respray.png', openSubMenu = 'stickers'},
                {label = 'Extras', img = 'img/icons/plus.png', modType = 'extras', priceMult = 2.0},
                {label = 'Ventanilla', img = 'img/icons/door.png', modType = 'windowTint', priceMult = 1.12, onSelect = function()
                    moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'window_lf', {x = -2.0, y = 0.0, z = 0.0}, {x = 0.0, y = 0.0, z = -10.0})
                end, onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end},
                {label = 'Claxon', img = 'img/icons/horn.png', modType = 14, priceMult = 1.12},
                {label = 'Interior', img = 'img/icons/body.png', modType = 27, priceMult = 6.98},
                {label = 'Placa', img = '', modType = 35, priceMult = 4.19},
                {label = 'Altavoz', img = 'img/icons/speaker.png', modType = 36, priceMult = 6.98},
                {label = 'Equipaje', img = 'img/icons/trunk.png', modType = 37, priceMult = 5.58, onSelect = function() openDoors(customVehicle, {0,0,0,0,0,1,1}) end},
                {label = 'Hidráulico', img = 'img/icons/hydrulics.png', modType = 38, priceMult = 5.12},
                {label = 'Cubierta del motor', img = 'img/icons/engine_block.png', modType = 39, priceMult = 5.12, onSelect = function() openDoors(customVehicle, {0,0,0,0,1,0,0}) end},
                {label = 'Filtro de aire', img = 'img/icons/air_filter.png', modType = 40, priceMult = 3.72},
                {label = 'Struts', img = 'img/icons/suspension.png', modType = 41, priceMult = 6.51},
                {label = 'Tanque de gasolina', img = 'img/icons/gas_tank.png', modType = 45, priceMult = 4.19},
            },
            onBack = function() updateMenu('main') end
        },
            ['body_parts'] = {
                title = 'Body Kit',
                options = {
                    {label = 'Spoiler', img = 'img/icons/spoiler.png', modType = 0, priceMult = 2.65},
                    {label = 'Parachoques delantero', img = 'img/icons/bumper.png', modType = 1, priceMult = 2.12},
                    {label = 'Parachoques trasero', img = 'img/icons/bumper.png', modType = 2, priceMult = 2.12, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'bumper_r', {x = 0.0, y = -4.0, z = 1.5}, {x = -30.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Faldones laterales', img = 'img/icons/bumper.png', modType = 3, priceMult = 2.65, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'wheel_lf', {x = -2.5, y = 0.0, z = 0.0}, {x = 0.0, y = 0.0, z = -20.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Escape', img = 'img/icons/exhaust.png', modType = 4, priceMult = 2.12, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'bumper_r', {x = 0.0, y = -4.0, z = 1.5}, {x = -30.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Jaula', img = 'img/icons/body.png', modType = 5, priceMult = 2.12, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'interiorlight', {x = 0.0, y = 1.0, z = -0.1}, {x = 0.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Parrilla', img = '', modType = 6, priceMult = 2.72},
                    {label = 'Capó', img = 'img/icons/hood.png', modType = 7, priceMult = 2.88},
                    {label = 'Maletero', img = 'img/icons/bumper.png', modType = 8, priceMult = 2.12},
                    {label = 'Aleron de techo', img = 'img/icons/bumper.png', modType = 9, priceMult = 2.12},
                    {label = 'Techo', img = '', modType = 10, priceMult = 2.58},
                    {label = 'Kafes', img = 'img/icons/bumper.png', modType = 42, priceMult = 4.19},
                    {label = 'Anten', img = '', modType = 43, priceMult = 1.12},
                    {label = 'Kanat', img = 'img/icons/bumper.png', modType = 44, priceMult = 6.05},
                    {label = 'Cam', img = 'img/icons/door.png', modType = 46, priceMult = 1.0},
                },
                onBack = function() updateMenu('visual') end
            },
            ['inside_parts'] = {
                title = 'Kit interior',
                options = {
                    {label = 'Tablero', img = 'img/icons/dashboard.png', modType = 29, priceMult = 4.65},
                    {label = 'Velocimetro', img = 'img/icons/dashboard.png', modType = 30, priceMult = 4.19},
                    {label = 'Altavoz de puerta', img = 'img/icons/speaker.png', modType = 31, priceMult = 5.58, onSelect = function() openDoors(customVehicle, {1,1,1,1,0,0,0}) end},
                    {label = 'Asientos', img = 'img/icons/seat.png', modType = 32, priceMult = 4.65},
                    {label = 'Volante', img = 'img/icons/steering_wheel.png', modType = 33, priceMult = 4.19},
                    {label = 'Palanca', img = 'img/icons/shifter_leaver.png', modType = 34, priceMult = 3.26},
                    {label = 'Ornamentos', img = '', modType = 28, priceMult = 0.9},
                },
                onBack = function() updateMenu('visual') end
            },
            ['respray'] = {
                title = 'Pintura',
                options = {
                    {label = 'Primario', img = 'img/icons/respray.png', modType = 'color1', customType = 'customColor', priceMult = 1.12, onSelect = function() openColorPicker('Primary Color', 'color1', true, 0.1) end},
                    {label = 'Secundario', img = 'img/icons/respray.png', modType = 'color2', customType = 'customColor', priceMult = 0.66, onSelect = function() openColorPicker('Secondary Color', 'color2', true, 0.5) end},
                    {label = 'Tipo de pintura primaria', img = 'img/icons/respray.png', modType = 'paintType1', priceMult = 0.5},
                    {label = 'Tipo de pintura secundaria', img = 'img/icons/respray.png', modType = 'paintType2', priceMult = 0.5},
                    {label = 'Perlado', img = 'img/icons/respray.png', modType = 'pearlescentColor', customType = 'color', priceMult = 0.88, onSelect = function() openColorPicker('Pearlescent Color', 'pearlescentColor', false, 0.5) end},
                },
                onBack = function() updateMenu('visual') end
            },
            ['wheels'] = {
                title = 'Ruedas',
                options = {
                    {label = 'Tipos de ruedas', img = 'img/icons/wheel.png', onSelect = function() updateMenu('wheels_type') end},
                    {label = 'Color de las ruedas', img = 'img/icons/respray.png', modType = 'wheelColor', customType = 'color', priceMult = 0.66, onSelect = function() openColorPicker('Wheels Color', 'wheelColor', false, 0.5) end},
                    {label = 'Humo de ruedas', img = 'img/icons/respray.png', modType = 'tyreSmokeColor', customType = 'customColor', priceMult = 1.12, onSelect = function() openColorPicker('Tyre Smoke Color', 'tyreSmokeColor', true, 0.5) end},
                },
                onBack = function() updateMenu('visual') SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true) end
            },
                ['wheels_type'] = {
                    title = 'Tipos de ruedas',
                    options = {
                        {label = 'Sport', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 0) end},
                        {label = 'Muscle ', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 1) end},
                        {label = 'Lowrider', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 2) end},
                        {label = 'SUV', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 3) end},
                        {label = 'Offroad', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 4) end},
                        {label = 'Tuner', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 5) end},
                        {label = 'Bike Wheels', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 6) end},
                        {label = 'High End', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 7) end},
                        {label = 'Bennys Original', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 8) end},
                        {label = 'Bennys Bespoke', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 9) end},
                        {label = 'Open Wheel', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 10) end},
                        {label = 'Street', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 11) end},
                        {label = 'Track', img = 'img/icons/wheel.png', modType = 23, priceMult = 1.65, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 12) end},
                    
                    },
                    onBack = function() updateMenu('wheels') end
                },
            ['plate'] = {
                title = 'Placa',
                options = {
                    {label = 'Soporte', img = 'img/icons/plate.png', modType = 25, priceMult = 1.1},
                    {label = 'Color', img = 'img/icons/respray.png', modType = 'plateIndex', priceMult = 1.1, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'bumper_r', {x = -2.0, y = -2.0, z = 1.5}, {x = -30.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Titular', img = 'img/icons/bumper.png', modType = 26, priceMult = 3.49},
                },
                onBack = function() updateMenu('visual') end
            },
            ['lights'] = {
                title = 'Luces',
                options = {
                    {label = 'Xenon', img = 'img/icons/headlights.png', modType = 'modXenon', priceMult = 0.1, onSelect = function() SetVehicleEngineOn(customVehicle, true, false, false) end},
                    {label = 'Neon', img = 'img/icons/headlights.png', modType = 'neonColor', customType = 'customColor', priceMult = 1.12, onSelect = function() SetVehicleEngineOn(customVehicle, true, false, false) openColorPicker('Neon Color', 'neonColor', true, 0.5) end},
                },
                onBack = function() updateMenu('visual') end
            },
            ['stickers'] = {
                title = 'Stickers',
                options = {
                    {label = 'Stickers', img = 'img/icons/respray.png', modType = 48, priceMult = 6.0},
                    {label = 'Superponer', img = 'img/icons/respray.png', modType = 'livery', priceMult = 6.0},
                },
                onBack = function() updateMenu('visual') end
            },
}