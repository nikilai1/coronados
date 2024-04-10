
local MeeleWeapons = {
    ["WEAPON_UNARMED"] = 0.1,
    ["WEAPON_NIGHTSTICK"] = 0.1
}

Citizen.CreateThread(function()
        Citizen.Wait(100)

		for weapon, modifier in pairs(MeeleWeapons) do
			SetWeaponDamageModifier(weapon, modifier)
		end
end)