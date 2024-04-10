Config = Config or {}

Config.menu = 'qb-menu' -- keep-menu (recommended) / qb-menu

Config.model_loading = {
     timeout = 1500, --ms
     dealy = 50, --ms
}

Config.categories = {
     ['misc'] = {
          key = 'misc',
          label = 'Misc',
          icon = 'fa-solid fa-tags',
          jobs = {},
     },
     ['misc2'] = {
          key = 'misc2',
          label = 'Partes de Armas',
          icon = 'fa-solid fa-tags',
          jobs = {},
     },
     ['ammo'] = {
          key = 'ammo',
          label = 'Municion',
          icon = 'fa-solid fa-tags',
          jobs = {},
     },
     ['grenade'] = {
          key = 'grenade',
          label = 'Granadas',
          icon = 'fa-solid fa-tags',
          jobs = {},
     },
     ['pistol'] = {
          key = 'pistol',
          label = 'Pistol',
          icon = 'fa-solid fa-gun',
          jobs = {},
          sub_categories = {
               ['sub_pistol'] = {
                    label = 'Pistol',
               },
               ['sub_acc_pistol'] = {
                    label = 'Acc',
               },
          }
     },
     ['smg'] = {
          key = 'smg',
          label = 'Smg',
          icon = 'fa-solid fa-gun',
          jobs = {},
          sub_categories = {
               ['sub_smg'] = {
                    label = 'Smg',
               },
               ['sub_acc_smg'] = {
                    label = 'Acc',
               },
          }
     },
     ['rifle'] = {
          key = 'rifle',
          label = 'Rifle',
          icon = 'fa-solid fa-gun',
          jobs = {},
          sub_categories = {
               ['sub_rifle'] = {
                    label = 'Rifle',
               },
               ['sub_acc_rifle'] = {
                    label = 'Acc',
               },
          }
     },
     ['medical'] = {
          key = 'medical',
          label = 'Medical',
          icon = 'fa-solid fa-hand-holding-medical',
          jobs = {"ambulance"}
     },
     ['medical_publico'] = {
          key = 'medical_publico',
          label = 'Salud',
          icon = 'fa-solid fa-hand-holding-medical',
          jobs = {}
     }
}

Config.permanent_items = {
     'wrench'
}

local misc_recipe = {
     ['repairkit'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Repair kit',
               -- icon = 'fa-solid fa-gun',
               object = {
                    name = 'v_ind_cs_toolbox4', -- <-- this model can fail to load
                    rotation = vector3(45.0, 0.0, -45.0)
               },
               image = 'repairkit', -- use inventory's images
               level = 40,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 30,
                    ["steel"] = 35,
               },
               exp_per_craft = 10
          }
     },
     ['radio'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Radio',
               image = 'radio', -- use inventory's images
               object = {
                    name = 'v_serv_radio',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["steel"] = 5,
                    ["plastic"] = 15,
               },
               exp_per_craft = 5
          }
     },
     ['lockpick'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Lockpick',
               image = 'lockpick', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["steel"] = 10,
                    ["rubber"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['tornillo_weapon'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Tornillo',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 1
          }
     },
}

local medial = {
     ['bandage'] = {
          categories = {
               main = 'medical',
          },
          item_settings = {
               label = 'Bandage',
               image = 'bandage', -- use inventory's images
               level = 0,
               job = {
                    allowed_list = {"ambulance"},
                    allowed_grades = {}
               },
               -- gang = {
               --      allowed_list = {},
               --      allowed_grades = {}
               -- }
          },
          crafting = {
               success_rate = 100,
               amount = 5, -- crafted amount
               duration = 15,
               materials = {
                    ["telaest_weapon"] = 5,
               },
               exp_per_craft = 0
          }
     },
}
local medial_publico = {
     ['bandage'] = {
          categories = {
               main = 'medical_publico',
          },
          item_settings = {
               label = 'Bandage2',
               image = 'bandage', -- use inventory's images
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },
               -- gang = {
               --      allowed_list = {},
               --      allowed_grades = {}
               -- }
          },
          crafting = {
               success_rate = 60,
               amount = 1, -- crafted amount
               duration = 10,
               materials = {
                    ["telaest_weapon"] = 5,
               },
               exp_per_craft = 0.15
          }
     },
}


local weapons_ammo = {
     ['pistol_ammo'] = {
          categories = {
               main = 'ammo',
          },
          item_settings = {
               label = 'Pistol ammo',
               image = 'pistol_ammo', -- use inventory's images
               object = {
                    name = 'prop_ld_ammo_pack_01',
                    rotation = vector3(250.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 80,
               amount = 1, -- crafted amount
               duration = 7,
               materials = {
                    ["stell"] = 5,
                    ["plomo_weapon"] = 4,
               },
               exp_per_craft = 0.25
          }
     },
     ['smg_ammo'] = {
          categories = {
               main = 'ammo',
          },
          item_settings = {
               label = 'SMG ammo',
               image = 'smg_ammo', -- use inventory's images
               object = {
                    name = 'prop_ld_ammo_pack_01',
                    rotation = vector3(250.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 70,
               amount = 1, -- crafted amount
               duration = 10,
               materials = {
                    ["stell"] =7,
                    ["plomo_weapon"] = 6,
               },
               exp_per_craft = 0.50
          }
     },
     ['rifle_ammo'] = {
          categories = {
               main = 'ammo',
          },
          item_settings = {
               label = 'Rifle ammo',
               image = 'rifle_ammo', -- use inventory's images
               object = {
                    name = 'prop_ld_ammo_pack_01',
                    rotation = vector3(250.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 60,
               amount = 1, -- crafted amount
               duration = 15,
               materials = {
                    ["stell"] = 10,
                    ["plomo_weapon"] = 8,
               },
               exp_per_craft = 1
          }
     },
     ['shotgun_ammo'] = {
          categories = {
               main = 'ammo',
          },
          item_settings = {
               label = 'Shotgun ammo',
               image = 'shotgun_ammo', -- use inventory's images
               object = {
                    name = 'prop_ld_ammo_pack_01',
                    rotation = vector3(250.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 70,
               amount = 1, -- crafted amount
               duration = 25,
               materials = {
                    ["stell"] =7,
                    ["plomo_weapon"] = 6,
               },
               exp_per_craft = 1
          }
     }
}

local weapons_pistol_recipe = {
     ['weapon_pistol'] = {
          categories = {
               sub = 'sub_pistol',
          },
          item_settings = {
               label = 'Walther P99',
               image = 'weapon_pistol', -- use inventory's images
               object = {
                    name = 'w_pi_pistol',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 15,
               materials = {
                    ["tornillo_weapon"] = 8,
                    ["muelle_weapon"] = 2,
                    ["canon_weapon"] = 1,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["corredera_weapon"] = 1,
               },
               exp_per_craft = 30
          }
     },['weapon_vintagepistol'] = {
          categories = {
               sub = 'sub_pistol',
          },
          item_settings = {
               label = 'Vintage Pistol',
               image = 'weapon_vintagepistol', -- use inventory's images
               object = {
                    name = 'w_pi_vintage_pistol',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 15,
               materials = {
                    ["tornillo_weapon"] = 8,
                    ["muelle_weapon"] = 2,
                    ["canon_weapon"] = 1,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["corredera_weapon"] = 1,
               },
               exp_per_craft = 30
          }
     },['weapon_pistol50'] = {
          categories = {
               sub = 'sub_pistol',
          },
          item_settings = {
               label = 'Pistol .50',
               image = 'weapon_pistol50', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 15,
               materials = {
                    ["tornillo_weapon"] = 12,
                    ["muelle_weapon"] = 2,
                    ["canon_weapon"] = 1,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["corredera_weapon"] = 1,
               },
               exp_per_craft = 30
          }
     },['pistol_suppressor'] = {
          categories = {
               sub = 'sub_acc_pistol',
          },
          item_settings = {
               label = 'Silenciador Pistol',
               image = 'pistol_suppressor', -- use inventory's images
               object = {
                    name = 'w_at_ar_supp_02',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 2,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 5
          }
     },['pistol_extendedclip'] = {
          categories = {
               sub = 'sub_acc_pistol',
          },
          item_settings = {
               label = 'Cargador Extendido Pistol',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_pi_pistol_mag2',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 2,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 5
          }
     },['pistol_flashlight'] = {
          categories = {
               sub = 'sub_acc_pistol',
          },
          item_settings = {
               label = 'Linterna Pistol',
               image = 'smg_flashlight', -- use inventory's images
               object = {
                    name = 'w_at_pi_flsh',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 2,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 5
          }
     },['pistol50_extendedclip'] = {
          categories = {
               sub = 'sub_acc_pistol',
          },
          item_settings = {
               label = 'Cargador Extendido Pistol .50',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50_mag2',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 2,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 5
          }
     },['vintagepistol_extendedclip'] = {
          categories = {
               sub = 'sub_acc_pistol',
          },
          item_settings = {
               label = 'Cargador Extendido Vintage Pistol',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_pi_vintage_pistol_mag2',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 2,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 5
          }
     }
}

local weapons_smg_recipe = {
     ['weapon_minismg'] = {
          categories = {
               sub = 'sub_smg',
          },
          item_settings = {
               label = 'Mini SMG',
               image = 'weapon_microsmg', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["tornillo_weapon"] = 16,
                    ["muelle_weapon"] = 6,
                    ["canon_weapon"] = 2,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["corredera_weapon"] = 1,
               },
               exp_per_craft = 0
          }
     },['weapon_machinepistol'] = {
          categories = {
               sub = 'sub_smg',
          },
          item_settings = {
               label = 'Tec-9',
               image = 'weapon_machinepistol', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["tornillo_weapon"] = 14,
                    ["muelle_weapon"] = 4,
                    ["canon_weapon"] = 2,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["corredera_weapon"] = 1,
               },
               exp_per_craft = 0
          }
     },['weapon_microsmg'] = {
          categories = {
               sub = 'sub_smg',
          },
          item_settings = {
               label = 'Micro SMG',
               image = 'weapon_microsmg', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["tornillo_weapon"] = 18,
                    ["muelle_weapon"] = 6,
                    ["canon_weapon"] = 2,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["corredera_weapon"] = 1,
               },
               exp_per_craft = 0
          }
     },['weapon_assaultsmg'] = {
          categories = {
               sub = 'sub_smg',
          },
          item_settings = {
               label = 'Assault SMG',
               image = 'weapon_assaultsmg', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["tornillo_weapon"] = 20,
                    ["muelle_weapon"] = 8,
                    ["canon_weapon"] = 3,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["corredera_weapon"] = 1,
                    ["culata_weapon"] = 1,
               },
               exp_per_craft = 0
          }
     },['minismg_extendedclip'] = {
          categories = {
               sub = 'sub_acc_smg',
          },
          item_settings = {
               label = 'Cargador Ampliado MiniSMG',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_pi_combatpistol_mag2',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },['machinepistol_extendedclip'] = {
          categories = {
               sub = 'sub_acc_smg',
          },
          item_settings = {
               label = 'Cargador Ampliado Tec-9',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_pi_combatpistol_mag2',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },['microsmg_extendedclip'] = {
          categories = {
               sub = 'sub_acc_smg',
          },
          item_settings = {
               label = 'Cargador Ampliado Micro SMG',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_pi_combatpistol_mag2',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },['microsmg_scope'] = {
          categories = {
               sub = 'sub_acc_smg',
          },
          item_settings = {
               label = 'Scope Micro SMG',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_at_scope_small',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },['assaultsmg_extendedclip'] = {
          categories = {
               sub = 'sub_acc_smg',
          },
          item_settings = {
               label = 'Cargador Ampliado Assault SMG',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_at_scope_small',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     }
}

local weapons_rifle_recipe = {
     ['weapon_assaultrifle'] = {
          categories = {
               sub = 'sub_rifle',
          },
          item_settings = {
               label = 'Assault Rifle',
               image = 'weapon_assaultrifle', -- use inventory's images
               object = {
                    name = 'w_ar_assaultrifle',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 180,
               materials = {
                    ["tornillo_weapon"] = 24,
                    ["muelle_weapon"] = 10,
                    ["canon_weapon"] = 4,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["cerrojo_weapon"] = 1,
                    ["culata_weapon"] = 1,
                    ["guardamano_weapon"] = 1,
                    ["mirilla_weapon"] = 1,
               },
               exp_per_craft = 0
          }
     },
     ['weapon_assaultrifle_mk2'] = {
          categories = {
               sub = 'sub_rifle',
          },
          item_settings = {
               label = 'Assault Rifle Mk II',
               image = 'weapon_assaultrifle_mk2', -- use inventory's images
               object = {
                    name = 'w_ar_assaultrifle',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 180,
               materials = {
                    ["tornillo_weapon"] = 26,
                    ["muelle_weapon"] = 10,
                    ["canon_weapon"] = 4,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["cerrojo_weapon"] = 1,
                    ["culata_weapon"] = 1,
                    ["guardamano_weapon"] = 1,
                    ["mirilla_weapon"] = 1,
               },
               exp_per_craft = 0
          }
     },
     ['weapon_compactrifle'] = {
          categories = {
               sub = 'sub_rifle',
          },
          item_settings = {
               label = 'Compact Rifle',
               image = 'weapon_compactrifle', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 180,
               materials = {
                    ["tornillo_weapon"] = 22,
                    ["muelle_weapon"] = 8,
                    ["canon_weapon"] = 3,
                    ["gatillo_weapon"] = 1,
                    ["martillo_weapon"] = 1,
                    ["seguro_weapon"] = 1,
                    ["cerrojo_weapon"] = 1,
                    ["culata_weapon"] = 1,
                    ["guardamano_weapon"] = 1,
                    ["mirilla_weapon"] = 1,
               },
               exp_per_craft = 0
          }
     },
     ['assaultrifle_extendedclip'] = {
          categories = {
               sub = 'sub_acc_rifle',
          },
          item_settings = {
               label = 'Cargador Ampliado Assault Rifle',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_ar_assaultrifle_mag2',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 90,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },
     ['assaultrifle_drum'] = {
          categories = {
               sub = 'sub_acc_rifle',
          },
          item_settings = {
               label = 'Cargador Ampliado Tambor Assault Rifle',
               image = 'rifle_drummag', -- use inventory's images
               object = {
                    name = 'w_mg_mg_mag1',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 90,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },
     ['rifle_flashlight'] = {
          categories = {
               sub = 'sub_acc_rifle',
          },
          item_settings = {
               label = 'Linterna Assault Rifle',
               image = 'smg_flashlight', -- use inventory's images
               object = {
                    name = 'w_at_ar_flsh',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 90,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },
     ['rifle_grip'] = {
          categories = {
               sub = 'sub_acc_rifle',
          },
          item_settings = {
               label = 'Grip Assault Rifle',
               image = 'smg_flashlight', -- use inventory's images
               object = {
                    name = 'w_at_ar_afgrip',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 90,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },
     ['rifle_suppressor'] = {
          categories = {
               sub = 'sub_acc_rifle',
          },
          item_settings = {
               label = 'Silenciador Assault Rifle',
               image = 'smg_flashlight', -- use inventory's images
               object = {
                    name = 'w_at_ar_supp',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 90,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },
     ['compactrifle_extendedclip'] = {
          categories = {
               sub = 'sub_acc_rifle',
          },
          item_settings = {
               label = 'Cargador Extendido Compact Rifle',
               image = 'pistol_extendedclip', -- use inventory's images
               object = {
                    name = 'w_mg_mg_mag1',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 90,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     },
     ['compactrifle_drum'] = {
          categories = {
               sub = 'sub_acc_rifle',
          },
          item_settings = {
               label = 'Cargador Extendido Compact Rifle',
               image = 'rifle_drummag', -- use inventory's images
               object = {
                    name = 'w_at_ar_supp',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 90,
               materials = {
                    ["stell"] =2,
               },
               exp_per_craft = 0
          }
     }
}
local weapons_grenade_recipe = {
     ['weapon_molotov'] = {
          categories = {
               main = 'grenade',
          },
          item_settings = {
               label = 'Molotov',
               image = 'weapon_molotov', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 180,
               materials = {
               },
               exp_per_craft = 0
          }
     },
     ['weapon_pipebomb'] = {
          categories = {
               main = 'grenade',
          },
          item_settings = {
               label = 'Pipe Bomb',
               image = 'weapon_pipebomb', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 180,
               materials = {
               },
               exp_per_craft = 0
          }
     }
}

local weapons_parts_recipe = {
     ['tornillo_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Tornillo',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['muelle_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Muelle',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['canon_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Cañon',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['gatillo_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Gatillo',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['martillo_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Martillo',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['seguro_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Seguro',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['corredera_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Corredera',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['culata_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Culata',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['cerrojo_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Cerrojo',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['guardamano_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Empuñadura',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     },
     ['mirilla_weapon'] = {
          categories = {
               main = 'misc2',
          },
          item_settings = {
               label = 'Mirilla',
               image = 'c4', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               },

          },
          crafting = {
               show_level_in_mail = true,
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 5,
               materials = {
                    ["iron"] = 10,
               },
               exp_per_craft = 5
          }
     }
}



Config.workbench_default_model = ''

Config.workbenches = {
     -- test
     {
          table_model = "prop_ld_health_pack",
          coords = vector3(306.52, -566.95, 43.29),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, 350),
          -- just use either job or gang using both at same time won't work.
          job = {
               allowed_list = {"ambulance"},
               allowed_grades = {}
          },
           /*gang = {
                allowed_list = {"ballas"},
                allowed_grades = {}
          },*/
          categories = { Config.categories.misc, Config.categories.medical },
          recipes = { misc_recipe, medial },
          radius = 3.0
     },
     --[[{
          table_model = "gr_prop_gr_bench_02b",
          coords = vector3(295.18, -583.62, 42.21),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, 350),
          -- just use either job or gang using both at same time won't work.
          job = {
              allowed_list = {"ambulance"},
              allowed_grades = {}
          },
          /*gang = {
                allowed_list = {"ballas"},
                allowed_grades = {}
          },*/
          categories = { Config.categories.misc, Config.categories.pistol, Config.categories.smg, Config.categories.ammo, Config.categories.rifle, Config.categories.grenade, Config.categories.medical_publico},
          recipes = { misc_recipe, weapons_pistol_recipe, weapons_smg_recipe , weapons_ammo, weapons_rifle_recipe, weapons_grenade_recipe, medial_publico },
          radius = 3.0
     },]]
     {
          -- workbench 1 (publica)
          table_model = "gr_prop_gr_bench_02b",
          coords = vector3(2331.73, 2571.25, 45.68),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, -115),
          -- just use either job or gang using both at same time won't work.
          job = {
              allowed_list = {},
              allowed_grades = {}
          },
          /*gang = {
                allowed_list = {"ballas"},
                allowed_grades = {}
          },*/
          categories = {Config.categories.pistol, Config.categories.ammo},
          recipes = {weapons_pistol_recipe, weapons_ammo},
          radius = 3.0
     },
     {
          -- workbench 1 (kingscrips)
          table_model = "gr_prop_gr_bench_02b",
          coords = vector3(-807.64, 187.93, 71.48),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, -70),
          -- just use either job or gang using both at same time won't work.
          /*job = {
              allowed_list = {},
              allowed_grades = {}
          },*/
          gang = {
                allowed_list = {"cartel"},
                allowed_grades = {2,3}
          },
          categories = {Config.categories.misc2,Config.categories.pistol, Config.categories.smg, Config.categories.ammo},
          recipes = {weapons_parts_recipe,weapons_pistol_recipe, weapons_smg_recipe, weapons_ammo},
          radius = 3.0
     },
     --[[{
          -- workbench 2 (bandas)
          table_model = "gr_prop_gr_bench_02b",
          coords = vector3(2326.42, 2578.59, 46.67),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, -115),
          -- just use either job or gang using both at same time won't work.
          /*job = {
              allowed_list = {},
              allowed_grades = {}
          },
          */gang = {
                allowed_list = {},
                allowed_grades = {}
          },
          categories = {Config.categories.pistol, Config.categories.smg, Config.categories.ammo},
          recipes = {weapons_pistol_recipe, weapons_smg_recipe, weapons_ammo},
          radius = 3.0
     },
     {
          -- workbench 3 (mafia)
          table_model = "gr_prop_gr_bench_02b",
          coords = vector3(2321.09, 2582.66, 46.65),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, -115),
          -- just use either job or gang using both at same time won't work.
          /*job = {
              allowed_list = {},
              allowed_grades = {}
          },
          */gang = {
                allowed_list = {},
                allowed_grades = {}
          },
          categories = {Config.categories.pistol, Config.categories.rifle, Config.categories.ammo},
          recipes = {weapons_pistol_recipe, weapons_rifle_recipe, weapons_ammo},
          radius = 3.0
     }]]/*,

     -- items
     {
          table_model = "gr_prop_gr_bench_04b",
          coords = vector3(1346.55, 4391.04, 43.36),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, 350),
          -- just use either job or gang using both at same time won't work.
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          -- gang = {
          --      allowed_list = {},
          --      allowed_grades = {}
          -- },
          categories = { Config.categories.misc, Config.categories.medical },
          recipes = { misc_recipe, medial },
          radius = 3.0
     },
     {
          table_model = 'gr_prop_gr_bench_04b',
          coords = vector3(-59.5, 6388.77, 30.49),
          rotation = vector3(0.0, 0.0, 225.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = { Config.categories.misc, Config.categories.medical },
          recipes = { misc_recipe, medial },
          radius = 3.0
     },
     -- gun
     {
          table_model = 'gr_prop_gr_bench_02b',
          coords = vector3(68, 3684.62, 38.83),
          item_show_case_offset = vector3(0.0, 0.0, 1.2),
          rotation = vector3(0.0, 0.0, 235.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = { Config.categories.weapons },
          recipes = { weapons_pistol },
          radius = 3.0
     }, {
          table_model = 'gr_prop_gr_bench_02b',
          coords = vector3(2939.04, 4623.81, 47.72),
          item_show_case_offset = vector3(0.0, 0.0, 1.2),
          rotation = vector3(0.0, 0.0, 47.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = { Config.categories.weapons },
          recipes = { weapons_pistol },
          radius = 3.0
     }*/
}

--gr_prop_gr_jailer_keys_01a

-- gr_prop_gr_missle_long
-- gr_prop_gr_missle_short
-- gr_int02_generator_01
-- gr_prop_gr_hammer_01

-- w_sr_heavysnipermk2_mag2
-- w_sb_smgmk2_mag2
-- w_sb_smgmk2_mag1
-- w_pi_pistolmk2_mag1
-- w_mg_combatmgmk2_mag1
-- w_ar_carbineriflemk2_mag1
-- w_ar_assaultriflemk2_mag1
-- w_ex_vehiclemissile_3
-- w_ex_vehiclemissile_1
-- w_ex_vehiclemissile_2
-- w_ex_vehiclemortar

-- w_sg_pumpshotgunmk2_mag1
-- w_sg_pumpshotgunh4_mag1
-- gr_prop_gr_adv_case

-- w_at_pi_flsh_2
-- w_at_afgrip_2
-- w_at_muzzle_1
-- w_at_muzzle_3
-- w_at_muzzle_2
-- w_at_muzzle_5
-- w_at_muzzle_6
-- w_at_muzzle_7
-- w_at_muzzle_8
-- w_at_muzzle_9

-- w_at_pi_comp_1
-- w_at_pi_rail_1
-- w_at_scope_macro_2_mk2
-- w_at_scope_small_mk2
-- w_at_scope_medium_2
-- w_at_scope_nv
-- w_at_sights_1
-- w_at_sights_smg
-- w_at_sr_supp3


-- gr_prop_gr_drill_01a

-- gr_prop_gr_driver_01a
-- gr_prop_gr_pliers_01
-- gr_prop_gr_pliers_02
-- gr_prop_gr_rasp_01
-- gr_prop_gr_rasp_02
-- gr_prop_gr_rasp_03
-- gr_prop_gr_sdriver_01
-- gr_prop_gr_sdriver_02
-- gr_prop_gr_sdriver_03

-- gr_prop_gr_vice_01a
