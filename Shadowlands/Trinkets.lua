-- Shadowlands/Trinkets.lua
-- November 2020

local addon, ns = ...
local Hekili = _G[ addon ]

local all = Hekili.Class.specs[ 0 ]


-- 9.0 Trinkets
do
    -- Trinket auras (not on-use effects)    
    all:RegisterAuras( {
        anima_field = {
            id = 345535,
            duration = 8,
            max_stack = 1
        },

        beating_abomination_core = {
            id = 336871,
            duration = 15,
            max_stack = 1
        },

        booksmart = {
            id = 340020,
            duration = 12,
            max_stack = 1,
        },

        -- Boon of the Archon
        -- ???

        crimson_chorus = {
            id = 344803,
            duration = 10,
            max_stack = 1
        },

        consumptive_infusion_proc = {
            id = 344225,
            duration = 15,
            max_stack = 1
        },

        consumptive_infusion = {
            id = 344227,
            duration = 10,
            max_stack = 1
        },

        dreamers_mending = {
            id = 339738,
            duration = 120,
            max_stack = 1,
        },

        everchill_brambles = {
            id = 339301,
            duration = 12,
            max_stack = 10,
        },

        everchill_brambles_root = {
            id = 339309,
            duration = 2,
            max_stack = 1
        },

        mote_of_anger = {
            id = 71432,
            duration = 3600,
            max_stack = 8
        },

        synaptic_feedback = {
            id = 344118,
            duration = 15,
            max_stack = 1
        },

        -- Murmurs in the Dark
        fall_of_night = {
            id = 339342,
            duration = 12,
            max_stack = 1
        },

        end_of_night = {
            id = 339341,
            duration = 8,
            max_stack = 1
        },
        -- End Murmurs

        phial_of_putrefaction = {
            id = 345464,
            duration = 10,
            max_stack = 1,
        },

        primalists_kelpling = {
            id = 268522,
            duration = 15,
            max_stack = 1
        },

        rejuvenating_serum = {
            id = 326377,
            duration = 6,
            max_stack = 1,
        },

        critical_resistance = {
            id = 336371,
            duration = 20,
            max_stack = 3
        },

        stone_legionnaire = {
            id = 344686,
            duration = 3600,
            max_stack = 1
        },

        caustic_liquid = {
            id = 329737,
            duration = 8,
            max_stack = 1
        },
    } )


    all:RegisterAbilities( {
        bargasts_leash = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 184017,
            toggle = "defensives",
            defensive = true,

            handler = function ()
                applyBuff( "huntsmans_bond" )
            end,

            usable = function ()
                return incoming_damage_3s > 0 and health.pct < 70, "requires incoming damage and health below 70 percent"
            end,

            auras = {
                huntsmans_bond = {
                    id = 344388,
                    duration = 30,
                    max_stack = 1
                }
            }
        },

        bladedancers_armor_kit = {
            cast = 0,
            cooldown = 300,
            gcd = "off",

            item = 178862,
            toggle = "cooldowns", -- TODO:  Review.

            handler = function ()
                applyBuff( "bladedancers_armor" )
            end,

            auras = {
                bladedancers_armor = {
                    id = 342423,
                    duration = 120,
                    max_stack = 1
                }
            }
        },

        bloodspattered_scale = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 179331,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "blood_barrier" )
            end,

            auras = {
                blood_barrier = {
                    id = 329840,
                    duration = 10,
                    max_stack = 1
                },
            },
        },

        bottled_flayedwing_toxin = {
            cast = 0,
            cooldown = 20,
            gcd = "off",

            item = 178742,

            readyTime = function ()
                if combat > 0 then return buff.flayedwing_toxin.remains end
                return buff.flayedwing_toxin.remains - 600
            end,
            handler = function ()
                applyBuff( "flayedwing_toxin" )
            end,

            auras = {
                flayedwing_toxin = {
                    id = 345545,
                    duration = 3600,
                    max_stack = 1,
                    ignore_buff = true -- Don't count as a DPS self-buff.
                }
            }
        },

        brimming_ember_shard = {
            cast = 6,
            channeled = true,
            cooldown = 90,
            gcd = "spell",

            item = 175733,
            toggle = "cooldowns",
        },

        darkmoon_deck_indomitable = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 173096,
            toggle = "defensives",
            defensive = true,

            handler = function ()
                applyBuff( "indomitable_deck" )
            end,

            auras = {
                indomitable_deck = {
                    id = 311444,
                    duration = 10,
                    max_stack = 1
                }
            }
        },

        darkmoon_deck_putrescence = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 173069,
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "putrid_burst" )
            end,

            auras = {
                putrid_burst = {
                    id = 334058,
                    duration = 10,
                    max_stack = 1
                }
            },

            copy = "darkmoon_deck__putrescence" -- simc
        },

        darkmoon_deck_repose = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 173078,
        },

        darkmoon_deck_voracity = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 173087,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "voracious_haste" )
                applyDebuff( "target", "voracious_lethargy" )
            end,

            auras = {
                voracious_haste = {
                    id = 311491,
                    duration = 20,
                    max_stack = 1
                },

                voracious_lethargy = {
                    id = 329449,
                    duration = 20,
                    max_stack = 1
                }
            }
        },

        dreadfire_vessel = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 184030,
            toggle = "cooldowns",
        },

        empyreal_ordnance = {
            cast = 0,
            cooldown = 180,
            gcd = "off",

            item = 180117,
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "empyreal_ordnance" )
                active_dot.empyreal_ordnance = min( 5, active_enemies )
            end,

            auras = {
                empyreal_ordnance = {
                    id = 345540,
                    duration = 10,
                    max_stack = 1
                },

                empyreal_surge = {
                    id = 345541,
                    duration = 15,
                    max_stack = 1
                }
            }
        },

        flame_of_battle = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 181501,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "flame_of_battle" )
            end,

            auras = {
                flame_of_battle = {
                    id = 336841,
                    duration = 6,
                    max_stack = 1,
                }
            }
        },

        glyph_of_assimilation = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 184021,
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "glyph_of_assimilation" )
            end,

            auras = {
                glyph_of_assimilation = {
                    id = 345319,
                    duration = 10,
                    max_stack = 1
                },

                glyph_of_assimilation_buff = {
                    id = 345320,
                    duration = 20,
                    max_stack = 1
                }
            }
        },

        grim_codex = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 178811,
            toggle = "cooldowns",
        },

        inscrutable_quantum_device = {
            cast = 0,
            cooldown = 180,
            gcd = "off",

            item = 179350,
            toggle = "cooldowns",

            self_buff = "inscrutable_quantum_device",

            auras = {
                inscrutable_quantum_device_crit = {
                    id = 330366,
                    duration = 30,
                    max_stack = 1
                },
                inscrutable_quantum_device_vers = {
                    id = 330367,
                    duration = 30,
                    max_stack = 1
                },
                inscrutable_quantum_device_haste = {
                    id = 330368,
                    duration = 30,
                    max_stack = 1
                },
                inscrutable_quantum_device_mastery = {
                    id = 330380,
                    duration = 30,
                    max_stack = 1
                },
                inscrutable_quantum_device = {
                    alias = { "inscrutable_quantum_device_crit", "inscrutable_quantum_device_vers", "inscrutable_quantum_device_haste", "inscrutable_quantum_device_mastery" },
                    aliasMode = "first",
                    aliasType = "buff",
                    duration = 30
                }
            }
        },

        lingering_sunmote = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 178850,
            toggle = "defensives",
            defensive = true,

            handler = function ()
                applyBuff( "suns_embrace" )
            end,

            auras = {
                suns_embrace = {
                    id = 342435,
                    duration = 10,
                    max_stack = 1,
                }
            }
        },

        lyre_of_sacred_purpose = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 184841,
            toggle = "defensives",
            defensive = true,

            handler = function ()
                applyBuff( "lyre_of_sacred_purpose" )
            end,

            auras = {
                lyre_of_sacred_purpose = {
                    id = 348136,
                    duration = 15,
                    max_stack = 1
                }
            }
        },

        instructors_divine_bell = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 184842,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "instructors_divine_bell" )
            end,

            auras = {
                instructors_divine_bell = {
                    id = 348139,
                    duration = 9,
                    max_stack = 1
                }
            }
        },

        macabre_sheet_music = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 184024,
            toggle = "cooldowns",

            auras = {
                blood_waltz = {
                    id = 345439,
                    duration = 20,
                    max_stack = 1
                }
            }
        },

        maldraxxian_warhorn = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 180827,
            toggle = "cooldowns",
        },

        manabound_mirror = {
            cast = 0,
            cooldown = 60,
            gcd = "off",

            item = 184029,

            handler = function ()
                removeBuff( "manabound_mirror" )
            end,

            auras = {
                manabound_mirror = {
                    id = 344244,
                    duration = 30,
                    max_stack = 1
                }
            }
        },

        memory_of_past_sins = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 184025,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "shattered_psyche" )
            end,

            auras = {
                shattered_psyche = {
                    id = 344662,
                    duration = 30,
                    max_stack = 1,
                },

                shattered_psyche_debuff = {
                    id = 344663,
                    duration = 5,
                    max_stack = 1
                },
            }
        },

        mistcaller_ocarina = {
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            item = 178715,
            
            nobuff = "mistcaller_ocarina",

            handler = function ()
                applyBuff( "mistcaller_ocarina" )
            end,

            auras = {
                mistcaller_ocarina = {
                    id = 330067,
                    duration = 900,
                    max_stack = 1
                }
            }
        },

        overcharged_anima_battery = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 180116,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "overcharged_anima_battery" )
            end,

            auras = {
                overcharged_anima_battery = {
                    id = 345530,
                    duration = 16,
                    max_stack = 1
                }
            }
        },

        overflowing_anima_cage = {
            cast = 0,
            cooldown = 270,
            gcd = "off",

            item = 178849,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "anima_infusion" )
            end,

            auras = {
                anima_infusion = {
                    id = 343386,
                    duration = 15,
                    max_stack = 1
                }
            }
        },

        overflowing_ember_mirror = {
            cast = 0,
            cooldown = 270,
            gcd = "off",

            item = function ()
                if equipped[ 177657 ] then return 177657 end
                return 181359
            end,
            items = { 177657, 181359 },
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "pulsating_light_shield" )
            end,

            auras = {
                pulsating_light_shield = {
                    id = 336465,
                    duration = 12,
                    max_stack = 1
                }
            }
        },

        overwhelming_power_crystal = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 179342,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "power_overwhelming" )
            end,

            auras = {
                power_overwhelming = {
                    id = 329831,
                    duration = 15,
                    max_stack = 1
                }
            }
        },

        pulsating_stoneheart = {
            cast = 0,
            cooldown = 75,
            gcd = "off",

            item = 178825,
            toggle = "defensives",
            defensive = true,

            handler = function ()
                applyBuff( "heart_of_a_gargoyle" )
            end,

            auras = {
                heart_of_a_gargoyle = {
                    id = 343399,
                    duration = 12,
                    max_stack = 1,
                }
            }
        },

        sanguine_vintage = {
            cast = 0,
            cooldown = 60,
            gcd = "off",

            item = 184031,

            handler = function ()
                applyBuff( "sanguine_vintage" )
            end,

            auras = {
                sanguine_vintage = {
                    id = 344231,
                    duration = 6,
                    max_stack = 1
                }
            }
        },

        shadowgrasp_totem = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 179356,
            toggle = "cooldowns",

            self_buff = "shadowgrasp_totem",

            handler = function ()
                applyBuff( "shadowgrasp_totem" )
            end,

            auras = {
                shadowgrasp_totem = {
                    duration = 15,
                    max_stack = 1,
                }
            }
        },

        siphoning_phylactery_shard = {
            cast = 0,
            cooldown = 30,
            gcd = "off",

            item = 178783,
            
            handler = function ()
                applyBuff( "charged_phylactery" )
            end,

            auras = {
                charged_phylactery = {
                    id = 345549,
                    duration = 30,
                    max_stack = 1
                }
            }
        },

        skulkers_wing = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 184016,
            toggle = "cooldowns",

            -- ???
        },

        slimy_consumptive_organ = {
            cast = 0,
            cooldown = 20,
            gcd = "off",

            item = 178770,
            toggle = "defensives",
            defensive = true,

            buff = "gluttonous",

            usable = function () return buff.gluttonous.stack > 8 and health.percent < 80, "requires gluttonous stacks and a health deficit" end,

            handler = function ()
                removeBuff( "gluttonous" )
            end,

            auras = {
                gluttonous = {
                    id = 334511,
                    duration = 3600,
                    max_stack = 9
                }
            }
        },

        soul_igniter = {
            cast = 0,
            cooldown = 0.5,
            gcd = "off",

            item = 184019,
            toggle = "cooldowns",

            nobuff = "soul_ignition",
            no_icd = true,

            handler = function ()
                applyBuff( "soul_ignition" )
            end,

            auras = {
                soul_ignition = {
                    id = 345211,
                    duration = 15,
                    max_stack = 1
                }
            }
        },


        soul_ignition = {
            cast = 0,
            cooldown = 60,

            toggle = "cooldowns",

            buff = "soul_ignition",

            indicator = "cancel",

            handler = function ()
                removeBuff( "soul_ignition" )
            end,
        },


        soulletting_ruby = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 178809,
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "soulletting_ruby" )
            end,

            auras = {
                soul_infusion = {
                    id = 345805,
                    duration = 16,
                    max_stack = 1
                },

                soulletting_ruby = {
                    id = 345801,
                    duration = 20,
                    max_stack = 1,
                }
            },

            copy = "soul_infusion"
        },

        spare_meat_hook = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 178751,
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "spare_meat_hook" )
            end,

            auras = {
                spare_meat_hook = {
                    id = 345548,
                    duration = 10,
                    max_stack = 1
                }
            }
        },

        sunblood_amethyst = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 178826,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "anima_font" )
            end,

            auras = {
                anima_font = {
                    id = 343396,
                    duration = 15,
                    max_stack = 1
                }
            }
        },

        tablet_of_despair = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = function ()
                if equipped[ 175732 ] then return 175732 end
                return 181357
            end,
            items = { 175732, 181357 },            
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "growing_despair" )
            end,

            auras = {
                growing_despair = {
                    id = 336182,
                    duration = 25,
                    max_stack = 1
                }
            }
        },

        tuft_of_smoldering_plumage = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 184020,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "tuft_of_smoldering_plumage" )
            end,

            auras = {
                tuft_of_smoldering_plumage = {
                    id = 344916,
                    duration = 6,
                    max_stack = 1
                }
            }
        },

        vial_of_spectral_essence = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 178810,
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "vial_of_spectral_essence" )
            end,

            auras = {
                vial_of_spectral_essence = {
                    id = 345695,
                    duration = 20,
                    max_stack = 1
                }
            }
        },

        wakeners_frond = {
            cast = 0,
            cooldown = 120,
            gcd = "off",

            item = 181457,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "wakeners_frond" )
            end,

            auras = {
                wakeners_frond = {
                    id = 336588,
                    duration = 12,
                    max_stack = 1
                }
            },
        },


        -- Sanctum of Domination, Usable Items
        jotungeirr_destinys_call = {
            cast = 0,
            cooldown = 180,
            gcd = "off",

            item = 186404,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "burden_of_divinity" )
            end,

            auras = {
                burden_of_divinity = {
                    id = 357773,
                    duration = 30,
                    max_stack = 1,
                },
            },
        },

        scrawled_word_of_recall = {
            cast = 0,
            cooldown = 60,
            gcd = "off",

            item = 186425,
            
            handler = function ()
                if spec.mistweaver then gainChargeTime( "renewing_mist", 7 )
                elseif class.druid and spec.restoration then gainChargeTime( "swiftmend", 7.9 )
                elseif spec.discipline then gainChargeTime( "penance", 7.2 )
                elseif class.priest and spec.holy then gainChargeTime( "circle_of_healing", 11.2 )
                elseif class.paladin and spec.holy then gainChargeTime( "holy_shock", 3.7 )
                elseif class.shaman and spec.restoration then gainChargeTime( "riptide", 4 ) end
            end,
        },

        forbidden_necromantic_tome = {
            cast = 2,
            cooldown = 600,
            gcd = "spell",

            item = 186421,
            toggle = "cooldowns",

            usable = function () return false, "NYI" end,
            handler = function ()
                applyBuff( "forbidden_necromancy" )
            end,

            auras = {
                forbidden_knowledge = {
                    id = 356029,
                    duration = 15,
                    max_stack = 1,
                },
                forbidden_necromancy = {
                    id = 356213,
                    duration = 32,
                    max_stack = 1,
                }
            }
        },

        soleahs_secret_technique = {
            cast = 0,
            cooldown = 0,
            gcd = "off",

            item = 185818,

            nobuff = "soleahs_secret_technique",

            disabled = function ()
                return not group, "only usable in a party/raid"
            end,

            handler = function ()
                applyBuff( "soleahs_secret_technique" )
            end,

            auras = {
                soleahs_secret_technique = {
                    id = 351952,
                    duration = 1800,
                    max_stack = 1,
                },
            },
        },

        shadowed_orb_of_torment = {
            cast = 2,
            channeled = true,
            cooldown = 120,
            gcd = "spell",
            
            toggle = "cooldowns",
            item = 186428,

            handler = function ()
                applyBuff( "tormented_insight" )
            end,

            auras = {
                tormented_insight = {
                    id = 356326,
                    duration = 40,
                    max_stack = 1,
                },
            },
        },

        relic_of_the_frozen_wastes = {
            cast = 0,
            cooldown = 60,
            gcd = "off",

            item = 186437,

            handler = function ()
                -- ???
            end,

            auras = {
                frozen_heart = {
                    id = 355759,
                    duration = 30,
                    max_stack = 1,
                },
            }
        },

        tome_of_monstrous_constructions = {
            cast = 2,
            cooldown = 60,
            gcd = "spell",

            item = 186422,

            nobuff = "studious_comprehension",
            usable = function () return buff.studious_comprehension.down, "not usable if studious_comprehension already buffed" end,
            essential = true,

            handler = function ()
                applyBuff( "studious_comprehension" )
            end,

            copy = 353692,

            auras = {
                studious_comprehension = {
                    id = 357163,
                    duration = 3600,
                    max_stack = 1,
                    shared = "player"
                },
            }
        },

        shard_of_annhyldes_aegis = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 186424,
            toggle = "defensives",

            handler = function ()
                applyBuff( "annhyldes_aegis" )
            end,

            auras = {
                annhyldes_aegis = {
                    id = 358712,
                    duration = 8,
                    max_stack = 1,
                },
            },
        },

        salvaged_fusion_amplifier = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 186432,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "salvaged_fusion_amplifier" )
            end,

            auras = {
                salvaged_fusion_amplifier = {
                    id = 355333,
                    duration = 20,
                    max_stack = 1,
                },
            },
        },

        ebonsoul_vice = {
            cast = 0,
            cooldown = 90,
            gcd = "off",

            item = 186431,
            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "ebonsoul_vise" )
            end,

            copy = "ebonsoul_vise",

            auras = {
                ebonsoul_vice = {
                    id = 355327,
                    duration = 12,
                    max_stack = 1,
                    copy = "ebonsoul_vise"
                },
                -- Shredded Soul implemented above.
            }
        },

        iron_maidens_toolkit = {
            cast = 0,
            cooldown = 150,
            gcd = "off",
            
            item = 185902,
            toggle = "cooldowns",

            handler = function ()
                applyBuff( "iron_spikes" )
            end,

            auras = {
                iron_spikes = {
                    id = 351872,
                    duration = 120,
                    max_stack = 1,
                },
            },
        },

        unchained_gladiators_shackles = {
            cast = 1,
            cooldown = 0,
            gcd = "spell",

            item = 186980,
            toggle = "interrupts",

            handler = function ()
                applyDebuff( "target", "shackles_of_malediction" )
            end,

            auras = {
                shackles_of_malediction = {
                    id = 356567,
                    duration = 4,
                    max_stack = 1,
                },
            },
        },
    } )


    -- Patch 9.1 Item Buffs
    all:RegisterAuras( {
        banshees_blight = {
            id = 357595,
            duration = 3600,
            max_stack = 4,
        },

        sadistic_glee = {
            id = 353466,
            duration = 6,
            max_stack = 1,
        },

        preternatural_charge = {
            id = 351531,
            duration = 3600,
            max_stack = 5
        },

        passable_credentials = {
            id = 352091,
            duration = 15,
            max_stack = 1,
        },

        fraudulent_credentials = {
            id = 351987,
            duration = 15,
            max_stack = 1,
        },

        worthy = {
            id = 355794,
            duration = 3600,
            max_stack = 1,
        },

        unworthy = {
            id = 355951,
            duration = 3600,
            max_stack = 1,
        },

        -- Active Rune Word:  Blood
        rune_word_blood = {
            id = 359420,
            duration = 3600,
            max_stack = 1,
        },

        -- Active Rune Word:  Frost
        rune_word_frost = {
            id = 355724,
            duration = 3600,
            max_stack = 1,
        },

        -- Active Rune Word:  Unholy
        rune_word_unholy = {
            id = 359435,
            duration = 3600,
            max_stack = 1,
        },

        -- Unholy Domination Shard Set
        soul_fragment = {
            id = 356042,
            duration = 30,
            max_stack = 15,
        },

        chaos_bane = {
            id = 356043,
            duration = 15,
            max_stack = 1,
        },
        -- End Unholy Domination Shard Set

        undying_rage = {
            id = 356490,
            duration = 3600,
            max_stack = 5,
        },

        decanted_warsong = {
            id = 356687,
            duration = 15,
            max_stack = 1,
        },

        strength_in_fealty = {
            id = 357185,
            duration = 20,
            max_stack = 1,
        },

        first_class_delivery = {
            id = 352274,
            duration = 9,
            max_stack = 1,
        },

        winds_of_winter = {
            id = 355735,
            duration = 20,
            max_stack = 1,
        },

        blood_link = {
            id = 355804,
            duration = 60,
            max_stack = 1,
        },

        reactive_defense_matrix = {
            id = 356813,
            duration = 10,
            max_stack = 1,
        },

        excruciating_twinge = {
            id = 356181,
            duration = 15,
            max_stack = 1,
        },

        shredded_soul = {
            id = 357785,
            duration = 20,
            max_stack = 1,
        },

        --[[ ??? Codex of the First Technique (Proc)
        first_technique = {

        }, ]]

        volatile_satchel = {
            id = 351682,
            duration = 15,
            max_stack = 3,
        },

        torturous_might = {
            id = 357673,
            duration = 15,
            max_stack = 1,
        },

        spark_of_insight = {
            id = 355044,
            duration = 20,
            max_stack = 1,
        },

        piercing_quill = {
            id = 355087,
            duration = 4,
            max_stack = 1,
        },
    } )
end