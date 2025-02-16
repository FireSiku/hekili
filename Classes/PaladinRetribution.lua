-- PaladinRetribution.lua
-- May 2018

local addon, ns = ...
local Hekili = _G[ addon ]

local class = Hekili.Class
local state = Hekili.State


local PTR = ns.PTR


-- Conduits
-- [x] expurgation
-- [-] templars_vindication
-- [x] truths_wake
-- [x] virtuous_command


if UnitClassBase( "player" ) == "PALADIN" then
    local spec = Hekili:NewSpecialization( 70 )

    spec:RegisterResource( Enum.PowerType.HolyPower, {
        divine_resonance = {
            aura = "divine_resonance",

            last = function ()
                local app = state.buff.divine_resonance.applied
                local t = state.query_time

                return app + floor( t - app )
            end,

            interval = 5,
            value = 1,
        },        
    } )
    spec:RegisterResource( Enum.PowerType.Mana )

    -- Talents
    spec:RegisterTalents( {
        zeal = 22590, -- 269569
        righteous_verdict = 22557, -- 267610
        execution_sentence = 23467, -- 343527

        fires_of_justice = 22319, -- 203316
        blade_of_wrath = 22592, -- 231832
        empyrean_power = 23466, -- 326732

        fist_of_justice = 22179, -- 234299
        repentance = 22180, -- 20066
        blinding_light = 21811, -- 115750

        unbreakable_spirit = 22433, -- 114154
        cavalier = 22434, -- 230332
        eye_for_an_eye = 22183, -- 205191

        divine_purpose = 17597, -- 223817
        holy_avenger = 17599, -- 105809
        seraphim = 17601, -- 152262

        selfless_healer = 23167, -- 85804
        justicars_vengeance = 22483, -- 215661
        healing_hands = 23086, -- 326734

        sanctified_wrath = 23456, -- 317866
        crusade = 22215, -- 231895
        final_reckoning = 22634, -- 343721
    } )

    -- PvP Talents
    spec:RegisterPvpTalents( { 
        aura_of_reckoning = 756, -- 247675
        blessing_of_sanctuary = 752, -- 210256
        divine_punisher = 755, -- 204914
        judgments_of_the_pure = 5422, -- 355858
        jurisdiction = 757, -- 204979
        law_and_order = 858, -- 204934
        lawbringer = 754, -- 246806
        luminescence = 81, -- 199428
        ultimate_retribution = 753, -- 355614
        unbound_freedom = 641, -- 305394
        vengeance_aura = 751, -- 210323
    } )

    -- Auras
    spec:RegisterAuras( {
        avenging_wrath = {
            id = 31884,
            duration = function () return ( azerite.lights_decree.enabled and 25 or 20 ) * ( talent.sanctified_wrath.enabled and 1.25 or 1 ) end,
            max_stack = 1,
        },

        avenging_wrath_autocrit = {
            id = 294027,
            duration = 20,
            max_stack = 1,
            copy = "avenging_wrath_crit"
        },

        blade_of_wrath = {
            id = 281178,
            duration = 10,
            max_stack = 1,
        },

        blessing_of_freedom = {
            id = 1044,
            duration = 8,
            type = "Magic",
            max_stack = 1,
        },

        blessing_of_protection = {
            id = 1022,
            duration = 10,
            type = "Magic",
            max_stack = 1,
        },

        blinding_light = {
            id = 115750,
            duration = 6,
            type = "Magic",
            max_stack = 1,
        },

        concentration_aura = {
            id = 317920,
            duration = 3600,
            max_stack = 1,
        },

        consecration = {
            id = 26573,
            duration = 12,
            max_stack = 1,
            generate = function( c, type )
                local dropped, expires

                c.count = 0
                c.expires = 0
                c.applied = 0
                c.caster = "unknown"

                for i = 1, 5 do
                    local up, name, start, duration = GetTotemInfo( i )

                    if up and name == class.abilities.consecration.name then
                        dropped = start
                        expires = dropped + duration
                        break
                    end
                end

                if dropped and expires > query_time then
                    c.expires = expires
                    c.applied = dropped
                    c.count = 1
                    c.caster = "player"
                end
            end
        },

        crusade = {
            id = 231895,
            duration = 25,
            type = "Magic",
            max_stack = 10,
        },

        crusader_aura = {
            id = 32223,
            duration = 3600,
            max_stack = 1,
        },

        devotion_aura = {
            id = 465,
            duration = 3600,
            max_stack = 1,
        },

        divine_purpose = {
            id = 223819,
            duration = 12,
            max_stack = 1,
        },

        divine_shield = {
            id = 642,
            duration = 8,
            type = "Magic",
            max_stack = 1,
        },

        -- Check racial for aura ID.
        divine_steed = {
            id = 221885,
            duration = function () return 3 * ( 1 + ( conduit.lights_barding.mod * 0.01 ) ) end,
            max_stack = 1,
            copy = { 221886 },
        },

        empyrean_power = {
            id = 326733,
            duration = 15,
            max_stack = 1,
        },

        execution_sentence = {
            id = 343527,
            duration = 8,
            max_stack = 1,
        },

        eye_for_an_eye = {
            id = 205191,
            duration = 10,
            max_stack = 1,
        },

        final_reckoning = {
            id = 343721,
            duration = 8,
            max_stack = 1,
        },

        fires_of_justice = {
            id = 209785,
            duration = 15,
            max_stack = 1,
            copy = "the_fires_of_justice" -- backward compatibility
        },

        forbearance = {
            id = 25771,
            duration = 30,
            max_stack = 1,
        },

        hammer_of_justice = {
            id = 853,
            duration = 6,
            type = "Magic",
            max_stack = 1,
        },

        hand_of_hindrance = {
            id = 183218,
            duration = 10,
            type = "Magic",
            max_stack = 1,
        },

        hand_of_reckoning = {
            id = 62124,
            duration = 3,
            max_stack = 1,
        },

        holy_avenger = {
            id = 105809,
            duration = 20,
            max_stack = 1,
        },

        inquisition = {
            id = 84963,
            duration = 45,
            max_stack = 1,
        },

        judgment = {
            id = 197277,
            duration = 15,
            max_stack = 1,
        },

        reckoning = {
            id = 343724,
            duration = 15,
            max_stack = 1,
        },

        retribution_aura = {
            id = 183435,
            duration = 3600,
            max_stack = 1,
        },

        righteous_verdict = {
            id = 267611,
            duration = 6,
            max_stack = 1,
        },

        selfless_healer = {
            id = 114250,
            duration = 15,
            max_stack = 4,
        },

        seraphim = {
            id = 152262,
            duration = 15,
            max_stack = 1,
        },

        shield_of_the_righteous = {
            id = 132403,
            duration = 4.5,
            max_stack = 1,
        },

        shield_of_vengeance = {
            id = 184662,
            duration = 15,
            max_stack = 1,
        },

        the_magistrates_judgment = {
            id = 337682,
            duration = 15,
            max_stack = 1,
        },

        -- what is the undead/demon stun?
        wake_of_ashes = { -- snare.
            id = 255937,
            duration = 5,
            max_stack = 1,
        },

        zeal = {
            id = 269571,
            duration = 20,
            max_stack = 3,
        },


        -- Generic Aura to cover any Aura.
        paladin_aura = {
            alias = { "concentration_aura", "crusader_aura", "devotion_aura", "retribution_aura" },
            aliasMode = "first",
            aliasType = "buff",
            duration = 3600,
        },


        -- Azerite Powers
        empyreal_ward = {
            id = 287731,
            duration = 60,
            max_stack = 1,
        },


        -- PvP
        reckoning = {
            id = 247677,
            max_stack = 30,
            duration = 30
        },


        -- Legendaries
        blessing_of_dawn = {
            id = 337767,
            duration = 12,
            max_stack = 1
        },

        blessing_of_dusk = {
            id = 337757,
            duration = 12,
            max_stack = 1
        },

        final_verdict = {
            id = 337228,
            duration = 15,
            type = "Magic",
            max_stack = 1,
        },

        relentless_inquisitor = {
            id = 337315,
            duration = 12,
            max_stack = 20
        },


        -- Conduits
        expurgation = {
            id = 344067,
            duration = 6,
            max_stack = 1
        }
    } )

    spec:RegisterGear( "tier19", 138350, 138353, 138356, 138359, 138362, 138369 )
    spec:RegisterGear( "tier20", 147160, 147162, 147158, 147157, 147159, 147161 )
        spec:RegisterAura( "sacred_judgment", {
            id = 246973,
            duration = 8
        } )

    spec:RegisterGear( "tier21", 152151, 152153, 152149, 152148, 152150, 152152 )
        spec:RegisterAura( "hidden_retribution_t21_4p", {
            id = 253806,
            duration = 15
        } )

    spec:RegisterGear( "class", 139690, 139691, 139692, 139693, 139694, 139695, 139696, 139697 )
    spec:RegisterGear( "truthguard", 128866 )
    spec:RegisterGear( "whisper_of_the_nathrezim", 137020 )
        spec:RegisterAura( "whisper_of_the_nathrezim", {
            id = 207633,
            duration = 3600
        } )

    spec:RegisterGear( "justice_gaze", 137065 )
    spec:RegisterGear( "ashes_to_dust", 51745 )
        spec:RegisterAura( "ashes_to_dust", {
            id = 236106,
            duration = 6
        } )

    spec:RegisterGear( "aegisjalmur_the_armguards_of_awe", 140846 )
    spec:RegisterGear( "chain_of_thrayn", 137086 )
        spec:RegisterAura( "chain_of_thrayn", {
            id = 236328,
            duration = 3600
        } )

    spec:RegisterGear( "liadrins_fury_unleashed", 137048 )
        spec:RegisterAura( "liadrins_fury_unleashed", {
            id = 208410,
            duration = 3600,
        } )

    spec:RegisterGear( "soul_of_the_highlord", 151644 )
    spec:RegisterGear( "pillars_of_inmost_light", 151812 )
    spec:RegisterGear( "scarlet_inquisitors_expurgation", 151813 )
        spec:RegisterAura( "scarlet_inquisitors_expurgation", {
            id = 248289,
            duration = 3600,
            max_stack = 3
        } )

    spec:RegisterHook( "prespend", function( amt, resource, overcap )
        if resource == "holy_power" and amt < 0 and buff.holy_avenger.up then
            return amt * 3, resource, overcap
        end
    end )


    spec:RegisterHook( "spend", function( amt, resource )
        if amt > 0 and resource == "holy_power" then
            if talent.crusade.enabled and buff.crusade.up then
                addStack( "crusade", buff.crusade.remains, amt )
            end
            if talent.fist_of_justice.enabled then
                setCooldown( "hammer_of_justice", max( 0, cooldown.hammer_of_justice.remains - 2 * amt ) )
            end
            if legendary.uthers_devotion.enabled then
                setCooldown( "blessing_of_freedom", max( 0, cooldown.blessing_of_freedom.remains - 1 ) )
                setCooldown( "blessing_of_protection", max( 0, cooldown.blessing_of_protection.remains - 1 ) )
                setCooldown( "blessing_of_sacrifice", max( 0, cooldown.blessing_of_sacrifice.remains - 1 ) )
                setCooldown( "blessing_of_spellwarding", max( 0, cooldown.blessing_of_spellwarding.remains - 1 ) )
            end
            if legendary.relentless_inquisitor.enabled then
                if buff.relentless_inquisitor.stack < 6 then
                    stat.haste = stat.haste + 0.01
                end
                addStack( "relentless_inquisitor" )
            end
            if legendary.of_dusk_and_dawn.enabled and holy_power.current == 0 then applyBuff( "blessing_of_dusk" ) end
        end
    end )

    spec:RegisterHook( "gain", function( amt, resource, overcap )
        if legendary.of_dusk_and_dawn.enabled and amt > 0 and resource == "holy_power" and holy_power.current == 5 then
            applyBuff( "blessing_of_dawn" )
        end
    end )

    spec:RegisterStateExpr( "time_to_hpg", function ()
        return max( gcd.remains, min( cooldown.judgment.true_remains, cooldown.crusader_strike.true_remains, cooldown.blade_of_justice.true_remains, ( state:IsUsable( "hammer_of_wrath" ) and cooldown.hammer_of_wrath.true_remains or 999 ), cooldown.wake_of_ashes.true_remains, ( race.blood_elf and cooldown.arcane_torrent.true_remains or 999 ), ( covenant.kyrian and cooldown.divine_toll.true_remains or 999 ) ) )
    end )

    spec:RegisterHook( "reset_precast", function ()
        --[[ Moved to hammer_of_wrath_hallow generator.
        if IsUsableSpell( 24275 ) and not ( target.health_pct < 20 or buff.avenging_wrath.up or buff.crusade.up or buff.final_verdict.up ) then
            applyBuff( "hammer_of_wrath_hallow", action.ashen_hallow.lastCast + 30 - now )
        end ]]
    end )


    spec:RegisterStateFunction( "apply_aura", function( name )
        removeBuff( "concentration_aura" )
        removeBuff( "crusader_aura" )
        removeBuff( "devotion_aura" )
        removeBuff( "retribution_aura" )

        if name then applyBuff( name ) end
    end )

    spec:RegisterStateFunction( "foj_cost", function( amt )
        if buff.fires_of_justice.up then return max( 0, amt - 1 ) end
        return amt
    end )


    -- Abilities
    spec:RegisterAbilities( {
        avenging_wrath = {
            id = 31884,
            cast = 0,
            cooldown = function () return ( essence.vision_of_perfection.enabled and 0.87 or 1 ) * ( level > 42 and 120 or 180 ) end,
            gcd = "off",

            toggle = "cooldowns",
            notalent = "crusade",

            startsCombat = true,
            texture = 135875,

            nobuff = "avenging_wrath",

            handler = function ()
                applyBuff( "avenging_wrath" )
                applyBuff( "avenging_wrath_crit" )
            end,
        },


        blade_of_justice = {
            id = 184575,
            cast = 0,
            cooldown = function () return 12 * haste end,
            gcd = "spell",

            spend = -2,
            spendType = "holy_power",

            startsCombat = true,
            texture = 1360757,

            handler = function ()
                removeBuff( "blade_of_wrath" )
                removeBuff( "sacred_judgment" )
            end,
        },


        blessing_of_freedom = {
            id = 1044,
            cast = 0,
            charges = 1,
            cooldown = 25,
            recharge = 25,
            gcd = "spell",

            spend = 0.07,
            spendType = "mana",

            startsCombat = false,
            texture = 135968,

            handler = function ()
                applyBuff( "blessing_of_freedom" )
            end,
        },


        blessing_of_protection = {
            id = 1022,
            cast = 0,
            charges = 1,
            cooldown = 300,
            recharge = 300,
            gcd = "spell",

            spend = 0.15,
            spendType = "mana",

            startsCombat = false,
            texture = 135964,

            readyTime = function () return debuff.forbearance.remains end,

            handler = function ()
                applyBuff( "blessing_of_protection" )
                applyDebuff( "player", "forbearance" )

                if talent.liadrins_fury_reborn.enabled then
                    gain( 5, "holy_power" )
                end
            end,
        },


        blinding_light = {
            id = 115750,
            cast = 0,
            cooldown = 90,
            gcd = "spell",

            spend = 0.06,
            spendType = "mana",

            talent = "blinding_light",

            startsCombat = true,
            texture = 571553,

            handler = function ()
                applyDebuff( "target", "blinding_light", 6 )
                active_dot.blinding_light = active_enemies
            end,
        },


        cleanse_toxins = {
            id = 213644,
            cast = 0,
            cooldown = 8,
            gcd = "spell",

            spend = 0.06,
            spendType = "mana",

            startsCombat = false,
            texture = 135953,

            usable = function ()
                return buff.dispellable_poison.up or buff.dispellable_disease.up, "requires poison or disease"
            end,

            handler = function ()
                removeBuff( "dispellable_poison" )
                removeBuff( "dispellable_disease" )
            end,
        },


        concentration_aura = {
            id = 317920,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135933,

            nobuff = "paladin_aura",

            handler = function ()
                apply_aura( "concentration_aura" )
            end,
        },


        consecration = {
            id = 26573,
            cast = 0,
            cooldown = 20,
            gcd = "spell",

            startsCombat = true,
            texture = 135926,

            handler = function ()
                applyBuff( "consecration" )
            end,
        },


        crusade = {
            id = 231895,
            cast = 0,
            cooldown = 120,
            gcd = "off",

            talent = "crusade",
            toggle = "cooldowns",

            startsCombat = false,
            texture = 236262,

            nobuff = "crusade",

            handler = function ()
                applyBuff( "crusade" )
            end,
        },


        crusader_aura = {
            id = 32223,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135890,

            nobuff = "paladin_aura",

            handler = function ()
                apply_aura( "crusader_aura" )
            end,
        },


        crusader_strike = {
            id = 35395,
            cast = 0,
            charges = 2,
            cooldown = function () return 6 * ( talent.fires_of_justice.enabled and 0.85 or 1 ) * haste end,
            recharge = function () return 6 * ( talent.fires_of_justice.enabled and 0.85 or 1 ) * haste end,
            gcd = "spell",

            spend = 0.09,
            spendType = "mana",

            startsCombat = true,
            texture = 135891,

            handler = function ()
                gain( buff.holy_avenger.up and 3 or 1, "holy_power" )
            end,
        },


        devotion_aura = {
            id = 465,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135893,

            nobuff = "paladin_aura",
            
            handler = function ()
                apply_aura( "devotion_aura" )
            end,
        },


        divine_shield = {
            id = 642,
            cast = 0,
            cooldown = function () return 300 * ( talent.unbreakable_spirit.enabled and 0.7 or 1 ) end,
            gcd = "spell",

            startsCombat = false,
            texture = 524354,

            readyTime = function () return debuff.forbearance.remains end,

            handler = function ()
                applyBuff( "divine_shield" )
                applyDebuff( "player", "forbearance" )

                if talent.liadrins_fury_reborn.enabled then
                    gain( 5, "holy_power" )
                end
            end,
        },


        divine_steed = {
            id = 190784,
            cast = 0,
            charges = function () return talent.cavalier.enabled and 2 or nil end,
            cooldown = function () return level > 48 and 30 or 45 end,
            recharge = function () return level > 48 and 30 or 45 end,
            gcd = "spell",

            startsCombat = false,
            texture = 1360759,

            handler = function ()
                applyBuff( "divine_steed" )
            end,
        },


        divine_storm = {
            id = 53385,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                if buff.empyrean_power.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 236250,

            handler = function ()
                removeDebuff( "target", "judgment" )

                if buff.empyrean_power.up or buff.divine_purpose.up then
                    removeBuff( "divine_purpose" )
                    removeBuff( "empyrean_power" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end

                if buff.avenging_wrath_crit.up then removeBuff( "avenging_wrath_crit" ) end
            end,
        },


        execution_sentence = {
            id = 343527,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            talent = "execution_sentence",

            startsCombat = true,
            texture = 613954,

            handler = function ()
                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
                applyDebuff( "target", "execution_sentence" )
            end,
        },


        eye_for_an_eye = {
            id = 205191,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            talent = "eye_for_an_eye",

            startsCombat = false,
            texture = 135986,

            handler = function ()
                applyBuff( "eye_for_an_eye" )
            end,
        },


        final_reckoning = {
            id = 343721,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            talent = "final_reckoning",

            startsCombat = true,
            texture = 135878,

            toggle = "cooldowns",

            handler = function ()
                applyDebuff( "target", "final_reckoning" )
            end,
        },


        flash_of_light = {
            id = 19750,
            cast = function () return ( 1.5 - ( buff.selfless_healer.stack * 0.5 ) ) * haste end,
            cooldown = 0,
            gcd = "spell",

            spend = 0.22,
            spendType = "mana",

            startsCombat = false,
            texture = 135907,

            handler = function ()
                removeBuff( "selfless_healer" )
            end,
        },


        hammer_of_justice = {
            id = 853,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            spend = 0.04,
            spendType = "mana",

            startsCombat = true,
            texture = 135963,

            handler = function ()
                applyDebuff( "target", "hammer_of_justice" )
            end,
        },


        hammer_of_reckoning = {
            id = 247675,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            startsCombat = true,
            -- texture = ???,

            pvptalent = "hammer_of_reckoning",

            usable = function () return buff.reckoning.stack >= 50 end,
            handler = function ()
                removeStack( "reckoning", 50 )
                if talent.crusade.enabled then
                    applyBuff( "crusade", 12 )
                else
                    applyBuff( "avenging_wrath", 6 )
                end
            end,
        },


        hammer_of_wrath = {
            id = 24275,
            cast = 0,
            charges = function () return legendary.vanguards_momentum.enabled and 2 or nil end,
            cooldown = function () return 7.5 * haste end,
            recharge = function () return legendary.vanguards_momentum.enabled and ( 7.5 * haste ) or nil end,
            gcd = "spell",

            spend = -1,
            spendType = "holy_power",

            startsCombat = true,
            texture = 613533,

            usable = function () return target.health_pct < 20 or ( level > 57 and ( buff.avenging_wrath.up or buff.crusade.up ) ) or buff.final_verdict.up or buff.hammer_of_wrath_hallow.up or buff.negative_energy_token_proc.up end,
            handler = function ()
                removeBuff( "final_verdict" )

                if legendary.the_mad_paragon.enabled then
                    if buff.avenging_wrath.up then buff.avenging_wrath.expires = buff.avenging_wrath.expires + 1 end
                    if buff.crusade.up then buff.crusade.expires = buff.crusade.expires + 1 end
                end

                if legendary.vanguards_momentum.enabled then
                    addStack( "vanguards_momentum" )
                end
            end,

            auras = {
                vanguards_momentum = {
                    id = 345046,
                    duration = 10,
                    max_stack = 3
                },

                -- Power: 335069
                negative_energy_token_proc = {
                    id = 345693,
                    duration = 5,
                    max_stack = 1,
                },
            }
        },


        hand_of_hindrance = {
            id = 183218,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            spend = 0.1,
            spendType = "mana",

            startsCombat = true,
            texture = 1360760,

            handler = function ()
                applyDebuff( "target", "hand_of_hindrance" )
            end,
        },


        hand_of_reckoning = {
            id = 62124,
            cast = 0,
            cooldown = 8,
            gcd = "spell",

            spend = 0.03,
            spendType = "mana",

            startsCombat = true,
            texture = 135984,

            handler = function ()
                applyDebuff( "target", "hand_of_reckoning" )
            end,
        },


        holy_avenger = {
            id = 105809,
            cast = 0,
            cooldown = 180,
            gcd = "off",

            toggle = "cooldowns",
            talent = "holy_avenger",

            startsCombat = true,
            texture = 571555,

            handler = function ()
                applyBuff( "holy_avenger" )
            end,
        },


        judgment = {
            id = 20271,
            cast = 0,
            charges = 1,
            cooldown = function () return 12 * haste end,
            gcd = "spell",

            spend = -1,
            spendType = "holy_power",

            startsCombat = true,
            texture = 135959,

            handler = function ()
                applyDebuff( "target", "judgment" )
                if talent.zeal.enabled then applyBuff( "zeal", 20, 3 ) end
                if set_bonus.tier20_2pc > 0 then applyBuff( "sacred_judgment" ) end
                if set_bonus.tier21_4pc > 0 then applyBuff( "hidden_retribution_t21_4p", 15 ) end
                if talent.sacred_judgment.enabled then applyBuff( "sacred_judgment" ) end
                if conduit.virtuous_command.enabled then applyBuff( "virtuous_command" ) end
            end,

            auras = {
                virtuous_command = {
                    id = 339664,
                    duration = 6,
                    max_stack = 1
                }
            }
        },


        justicars_vengeance = {
            id = 215661,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 5 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 135957,

            handler = function ()
                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
            end,
        },


        lay_on_hands = {
            id = 633,
            cast = 0,
            cooldown = function () return 600 * ( talent.unbreakable_spirit.enabled and 0.7 or 1 ) end,
            gcd = "off",

            startsCombat = false,
            texture = 135928,

            readyTime = function () return debuff.forbearance.remains end,

            handler = function ()
                gain( health.max, "health" )
                applyDebuff( "player", "forbearance", 30 )

                if talent.liadrins_fury_reborn.enabled then
                    gain( 5, "holy_power" )
                end

                if azerite.empyreal_ward.enabled then applyBuff( "empyreal_ward" ) end
            end,
        },


        rebuke = {
            id = 96231,
            cast = 0,
            cooldown = 15,
            gcd = "off",

            toggle = "interrupts",

            startsCombat = true,
            texture = 523893,

            debuff = "casting",
            readyTime = state.timeToInterrupt,

            handler = function ()
                interrupt()
            end,
        },


        redemption = {
            id = 7328,
            cast = function () return 10 * haste end,
            cooldown = 0,
            gcd = "spell",

            spend = 0.04,
            spendType = "mana",

            startsCombat = true,
            texture = 135955,

            handler = function ()
            end,
        },


        repentance = {
            id = 20066,
            cast = function () return 1.7 * haste end,
            cooldown = 15,
            gcd = "spell",

            spend = 0.06,
            spendType = "mana",

            startsCombat = false,
            texture = 135942,

            handler = function ()
                interrupt()
                applyDebuff( "target", "repentance", 60 )
            end,
        },


        retribution_aura = {
            id = 183435,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 135889,

            nobuff = "paladin_aura",

            handler = function ()
                apply_aura( "retribution_aura" )
            end,
        },


        seraphim = {
            id = 152262,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            spend = function () return 3 - ( buff.the_magistrates_judgment.up and 1 or 0 ) end,
            spendType = "holy_power",

            talent = "seraphim",

            startsCombat = false,
            texture = 1030103,

            handler = function ()
                applyBuff( "seraphim" )
            end,
        },


        shield_of_the_righteous = {
            id = 53600,
            cast = 0,
            cooldown = 1,
            gcd = "spell",

            spend = function () return 3  - ( buff.the_magistrates_judgment.up and 1 or 0 ) end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 236265,

            usable = function() return false end,
            handler = function ()
                applyBuff( "shield_of_the_righteous" )
                -- TODO: Detect that we're wearing a shield.
                -- Can probably use the same thing for Stormstrike requiring non-daggers, etc.
            end,
        },


        shield_of_vengeance = {
            id = 184662,
            cast = 0,
            cooldown = 120,
            gcd = "spell",

            startsCombat = true,
            texture = 236264,

            usable = function () return incoming_damage_3s > 0.2 * health.max, "incoming damage over 3s is less than 20% of max health" end,
            handler = function ()
                applyBuff( "shield_of_vengeance" )
            end,
        },


        templars_verdict = {
            id = 85256,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 461860,

            handler = function ()
                removeDebuff( "target", "judgment" )

                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
                if buff.vanquishers_hammer.up then removeBuff( "vanquishers_hammer" ) end
                if buff.avenging_wrath_crit.up then removeBuff( "avenging_wrath_crit" ) end
                if talent.righteous_verdict.enabled then applyBuff( "righteous_verdict" ) end
                if talent.divine_judgment.enabled then addStack( "divine_judgment", 15, 1 ) end

                removeStack( "vanquishers_hammer" )
            end,

            copy = { "final_verdict", 336872 }
        },


        vanquishers_hammer = {
            id = 328204,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            spend = function () return 1 - ( buff.the_magistrates_judgment.up and 1 or 0 ) end,
            spendType = "holy_power",

            startsCombat = true,
            texture = 3578228,

			handler = function ()
				applyBuff( "vanquishers_hammer" )
            end,

            auras = {
                vanquishers_hammer = {
                    id = 328204,
                    duration = 20,
                    max_stack = 1,
                }
            }
        },


        wake_of_ashes = {
            id = 255937,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            spend = -3,
            spendType = "holy_power",

            startsCombat = true,
            texture = 1112939,

            usable = function ()
                if settings.check_wake_range and not ( target.exists and target.within12 ) then return false, "target is outside of 12 yards" end
                return true
            end,

            handler = function ()
                if target.is_undead or target.is_demon then applyDebuff( "target", "wake_of_ashes" ) end
                if talent.divine_judgment.enabled then addStack( "divine_judgment", 15, 1 ) end
                if conduit.truths_wake.enabled then applyDebuff( "target", "truths_wake" ) end
            end,
        },


        --[[ wartime_ability = {
            id = 264739,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            startsCombat = true,
            texture = 1518639,

            handler = function ()
            end,
        }, ]]


        word_of_glory = {
            id = 85673,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function ()
                if buff.divine_purpose.up then return 0 end
                return 3 - ( buff.fires_of_justice.up and 1 or 0 ) - ( buff.hidden_retribution_t21_4p.up and 1 or 0 ) - ( buff.the_magistrates_judgment.up and 1 or 0 )
            end,
            spendType = "holy_power",

            startsCombat = false,
            texture = 133192,

            handler = function ()
                if buff.divine_purpose.up then removeBuff( "divine_purpose" )
                else
                    removeBuff( "fires_of_justice" )
                    removeBuff( "hidden_retribution_t21_4p" )
                end
                gain( 1.33 * stat.spell_power * 8, "health" )

                if conduit.shielding_words.enabled then applyBuff( "shielding_words" ) end
            end,
        },
    } )


    spec:RegisterOptions( {
        enabled = true,

        aoe = 3,

        nameplates = true,
        nameplateRange = 8,

        damage = true,
        damageExpiration = 8,

        potion = "spectral_strength",

        package = "Retribution",
    } )


    spec:RegisterSetting( "check_wake_range", false, {
        name = "Check |T1112939:0|t Wake of Ashes Range",
        desc = "If checked, when your target is outside of |T1112939:0|t Wake of Ashes' range, it will not be recommended.",
        type = "toggle",
        width = 1.5
    } )


    spec:RegisterPack( "Retribution", 20211123, [[dSusIbqiLqpIqkUeiO0MiuFIqsJIQOtrvyvif9kqIzbs6wIus7cLFPezyuv1XielJQkpdPKPHuQRbcTncj8ncjACes15iKswNifmpLOUhs1(ejhuKI0crk8qqqMiiO6IIue2iiO4JesPCsrkvwjvfZuKcDtrkv1ofPAOIueTurkXtfXuvc2QiLQ8vcPunwrkQ9kP)kQbdCyHftrpMOjtPldTzq9zcgTeDAvwniWRbrZMk3Mc7M0VLA4kPJlsPSCephvtxvxxP2ovPVlHXtvPZdsnFKSFfxfPUqnXgpwt3p)9tereXpAX8Jw0IwIaXAYd9kwtwdjKHawt0WaRjPf8jN5(VwRjRb0UoS1fQj8EtKynPMyUp3N2PvZAInESMUF(7NiIiIF0I5hTOfTeHw1e(kkRPlk9VMuEwlQvZAIf5YAsAbFYzU)R1bKMmCH90XN0BVOHjsgGi0cQdWp)9tKXNXhiuzOcipnm(KwhqAm4FALJYwTdyZdbCan8aEYPqIpFjieeoFaAxma4MmaZMZha8ju(8b0Qd6b4PTvr9hqrWFCaqiiC(aADapj4LEWgFsRdiTFajoGeKeRLNXaG3Q8VwhqrjQdacZPHBaPfuczRNkSuAcFr5(VwhqcQpQsCabbhqRdacbHpa4MmGyafLNdhGNWBYxIKbqqx4lAhqRdquUKO7bB8jToG0uRDaWHZLw)ssVfkhaeEYslK2BafLOoGeKeRLNXsqysldii4aSihAvwIwwnzL0WNdRjIgrZasl4toZ9FToG0KHlSNo(iAendi92lAyIKbicTG6a8ZF)ez8z8r0iAgaeQmubKNggFenIMbKwhqAm4FALJYwTdyZdbCan8aEYPqIpFjieeoFaAxma4MmaZMZha8ju(8b0Qd6b4PTvr9hqrWFCaqiiC(aADapj4LEWgFenIMbKwhqA)asCajijwlpJbaVv5FToGIsuhaeMtd3aslOeYwpvyP0e(IY9FToGeuFuL4accoGwhaeccFaWnzaXakkphoapH3KVejdGGUWx0oGwhGOCjr3d24JOr0mG06astT2bahoxA9lj9wOCaq4jlTqAVbuuI6asqsSwEglbHjTmGGGdWICOvzjAzJpJpH8Vw5SvckBdZ4PV2)164ti)RvoBLGY2WmEOqFjthY5NkKB4mFByGKXNq(xRC2kbLTHz8qH(sMoKZpvi3W5y)BdD8jK)1kNTsqzBygpuOVKPd58tfYnCU40hjJpH8Vw5SvckBdZ4Hc9LmDiNFQqUHZ8vYPcJpH8Vw5SvckBdZ4Hc9LcImum)nHG6d1dM(houFg8PHltqjKTEQad1W0HwXF4q9zCKeRLNbd1W0H2XNXNbm(iAendinHVOC)ODaOxKa9a(ZahWxIdiKFtgWXhq4noxy6q24ti)RvoDcAUHehFc5FTYHc9LKHZLd5FTMDh)HQggiDz3oBxO8XNq(xRCOqFjz4C5q(xRz3XFOQHbsxavKeFt4Jpdy8jK)1kNj72z7cLtFT)RvOEW0n3WWSWlQcNkKliXxY2RuuMByyMKS5Hfz7vXMByyMKS5Hfz8pKqsxe)POmBoxm8ju(zcAeNYx2pio(eY)ALZKD7SDHYHc9LCNq5ZZqW2kyG6d1dMoFfDU8heb85m3ju(8meSTcgO(PO7hf1IK4Sz0lQplSwod994pNIIeNnJEr9zH1YzNMsucrkksC2m6f1NfwlNTxhFc5FTYzYUD2Uq5qH(sWhbnDDBH6bt3CddZcVOkCQqUGeFjBVsrzUHHzsYMhwKTxfBUHHzsYMhwKX)qcjDr8F8jK)1kNj72z7cLdf6lXlp0zZnC2lQcyOseQhmDpx8dhQpd9fL7)AnZr9rvImudthAPOKD7SDHYqFr5(VwZCuFuLiJGgXP8LHOFEig(ek)mbnIt5PebIJpH8Vw5mz3oBxOCOqFjthY5NkKB4mFByGKXNq(xRCMSBNTluouOVKPd58tfYnCo2)2qhFc5FTYzYUD2Uq5qH(sMoKZpvi3W5ItFKm(eY)ALZKD7SDHYHc9LmDiNFQqUHZ8vYPcJpH8Vw5mz3oBxOCOqFPnhZ3JgqvddK(PCjz)HPdZPTDO)2iBrVNeH6bt3CddZcVOkCQqUGeFjBVsrzUHHzsYMhwKTxfBUHHzsYMhwKX)qcjDr8NIYS5CXWNq5NjOrCkFzA5)4ti)Rvot2TZ2fkhk0xAZX89Obu1WaP3Ersrj6moviV2fijljqZ)Wb1dMU5ggMfErv4uHCbj(s2ELIYCddZKKnpSiBVk2CddZKKnpSiJ)Hes6I4pfLzZ5IHpHYptqJ4u(YIaXXNq(xRCMSBNTluouOV0MJ57rdOQHbs3gein6wZwucz2Btc59qd1dMU5ggMfErv4uHCbj(s2ELIYCddZKKnpSiBVk2CddZKKnpSiJ)Hes6I4pfLzZ5IHpHYptqJ4u(Y(5)4ti)Rvot2TZ2fkhk0xAZX89Obu1WaPBeYWKGzEjIF2yZpjupy6MByyw4fvHtfYfK4lz7vkkZnmmts28WIS9QyZnmmts28WIm(hsiPlI)uuMnNlg(ek)mbnIt5l7N)JpH8Vw5mz3oBxOCOqFPnhZ3JgqvddKULGHf(iy2lY5OB8jK)1kNj72z7cLdf6lT5y(E0aQAyG05qUDqIeEU4uHXNq(xRCMSBNTluouOV0MJ57rdOQHbsxGCgzzBrFhFc5FTYzYUD2Uq5qH(sBoMVhnGQggiDd0OjqNB48AW)m)u(4ti)Rvot2TZ2fkhk0xAZX89Obu1WaPZxdcMnW4ZLDd54ti)Rvot2TZ2fkhk0xAZX89Obu1WaPZdN3qaTz4n)AnhgRUd(qY4ti)Rvot2TZ2fkhk0xAZX89Obu1WaPVvzzCkAZcUWEX3eE2mScyUHZWiPL3dnupy6MByyw4fvHtfYfK4lz7vkkZnmmts28WIS9QyZnmmts28WIm(hsitrxe)POKD7SDHYcVOkCQqUGeFjJGgXP8u0gIuuYUD2UqzsYMhwKrqJ4uEkAdXXNq(xRCMSBNTluouOV0MJ57rdOQHbsFRYY4u0Md(6rc95zZWkG5godJKwEp0q9GPBUHHzHxufovixqIVKTxPOm3WWmjzZdlY2RIn3WWmjzZdlY4FiHmfDr8NIs2TZ2fkl8IQWPc5cs8LmcAeNYtrBisrj72z7cLjjBEyrgbnIt5POnehFc5FTYzYUD2Uq5qH(sBoMVhnGQggiD(PWBxwWf2l(MWZMHvaZnCggjT8EOH6bt3CddZcVOkCQqUGeFjBVsrzUHHzsYMhwKTxfBUHHzsYMhwKX)qczk6I4pfLSBNTluw4fvHtfYfK4lze0ioLNI2qKIs2TZ2fkts28WImcAeNYtrBio(eY)ALZKD7SDHYHc9L2CmFpAavnmq68tH3UCWxpsOppBgwbm3WzyK0Y7HgQhmDZnmml8IQWPc5cs8LS9kfL5ggMjjBEyr2EvS5ggMjjBEyrg)djKPOlI)uuYUD2UqzHxufovixqIVKrqJ4uEkAdrkkz3oBxOmjzZdlYiOrCkpfTH44ti)Rvot2TZ2fkhk0xAZX89ObhQhmDZnmml8IQWPc5cs8LS9kfL5ggMjjBEyr2EvS5ggMjjBEyrg)djKPOlI)JpH8Vw5mz3oBxOCOqFPWlQcNkKliXxc1dMUNLTd68AxGKu0PT4)mWLHifvz7GoV2fijfDAj2Z)mWuqKIISveUjci7lXSriC8NepYZqW2kyG67bf1houFwz7GohErvajmudthAfl72z7cLv2oOZHxufqcJGgXPC6(7Hypx8dhQpJJKyT8myOgMo0srj72z7cLXrsSwEgmcAeNYt5pf1houFgpu5FWhAZfK4lzOgMo06X4ti)Rvot2TZ2fkhk0xss28WIq9GPx2oOZRDbssrN2I)ZaxgIuuLTd68AxGKu0PL4)mWuqKI6dhQpRSDqNdVOkGegQHPdTILD7SDHYkBh05WlQciHrqJ4uoD)hFc5FTYzYUD2Uq5qH(sbVe1Cz4CDX4ti)Rvot2TZ2fkhk0xQSDqNdVOkGeOEW0)ZaZFNlxfO7Vypn3WWSWlQcNkKliXxY2RuuMByyMKS5Hfz7vkkZnmml8IQWPc5cs8LmBxOILD7SDHYcVOkCQqUGeFjJGgXP8u02FkkZnmmts28WImBxOILD7SDHYKKnpSiJGgXP8u02FpgFc5FTYzYUD2Uq5qH(sWNgUmbLq26Pcq9GP7zz7GoV2fijfDAl(pdCzrNIQSDqNx7cKKIoTe)NbMIUO7Hyz3oBxOSWlQcNkKliXxYiOrCkpLG0k(pdm)DUCvGU)I9CXpCO(mosI1YZGHAy6qlfL5ggMXrsSwEgS9QhI9CrsC2m6f1NfwlNH(E8NtrrIZMrVO(SWA5S9kffjoBg9I6ZcRLZonfT93JXNbm(eY)ALZGp94LiHt3BqUW0HqvddKULNLb)dthcvVHBJ05ROZL)GiGpNzpVNIz(3ed6(jErpjBfHBIaYGpnCzViXEYx8houFg5ekFS38SxKyp5ZqnmDOvSSv7(E2JgRUGWZEp1EY4VwzOgMo06bffFfDU8heb85m759umZ)MyKYpkkZnmmdnwHMGHMx7cKW2RITO5ggMbbBRGbQpZ2fQyZnmmZEEpfZRBYAZrMTl0XNq(xRCg8PhVejCOqFjosI1YZaQhmDpLD7SDHYcVOkCQqUGeFjJGgXP8uIarkkz3oBxOmjzZdlYiOrCkpLiqKI6dhQpd(0WLjOeYwpvGHAy6qRhI9CXpCO(m4tdxMGsiB9ubgQHPdTuuYUD2UqzWNgUmbLq26PcmcAeNYt5N)qrqAPjTOOKD7SDHYGpnCzckHS1tfye0ioLVmDbPLM0sSNlsIZMrVO(SWA5m03J)CkksC2m6f1NfwlNDAkA7pffjoBg9I6ZcRLZoDzbPLIIeNnJEr9zH1Yz7vp8qSNl(Hd1NH(IY9FTM5O(OkrgQHPdTuuYUD2UqzOVOC)xRzoQpQsKrqJ4uEkAbrkkz3oBxOm0xuU)R1mh1hvjYiOrCkFz6cslnPff1houFg8PHltqjKTEQad1W0Hwpe75IY2lQH(miHMCHsrj72z7cLzpVNI5VDogbnIt5POnePOKD7SDHYSN3tX83ohJGgXP8LfT8GIYS5CXWNq5NjOrCkFzrGOy4tO8Ze0ioLNcIJpH8Vw5m4tpEjs4qH(sOVOC)xRzoQpQseQhmDpn3WWmjzZdlYSDHkw2TZ2fkts28WImcAeNYtjI)uuMByyMKS5Hfz8pKqMIoTOOKD7SDHYcVOkCQqUGeFjJGgXP8uI4VhI9CXpCO(m4tdxMGsiB9ubgQHPdTuuYUD2UqzWNgUmbLq26PcmcAeNYtjI)Ei(dIa(S)mW83z7HPe9XNq(xRCg8PhVejCOqFj759umZ)Mya1dMU3GCHPdzwEwg8pmDO4fn3WWmVHM22hVej8CzyyGe2EvSNEU4houFMKS5HfzOgMo0srj72z7cLjjBEyrgbnIt5PeKwAslpe75IF4q9zOVOC)xRzoQpQsKHAy6qlfLSBNTlug6lk3)1AMJ6JQeze0ioLNsqAPPOGIs2TZ2fkd9fL7)AnZr9rvImcAeNYtjiT0eIIlBh051UajPOtBkQpic4Z(ZaZFNThUSOtrT4houFghjXA5zWqnmDOvSSBNTlug6lk3)1AMJ6JQeze0ioLNsqAPPFEi2Zf)WH6ZGpnCzckHS1tfyOgMo0srj72z7cLbFA4YeuczRNkWiOrCkpLG0strbfLSBNTlug8PHltqjKTEQaJGgXP8ucslnHO4Y2bDETlqsk60MIAXpCO(mosI1YZGHAy6qRyz3oBxOm4tdxMGsiB9ubgbnIt5PeKwA6NhI9CXpCO(mosI1YZGHAy6qlfLSBNTlughjXA5zWiOrCkhcRG0cLY2bDETlqskArr9Hd1NbFA4YeuczRNkWqnmDOLI6dhQpd9fL7)AnZr9rvImudthAPOKTxud9zqcn5c1dkkp)WH6ZkBh05WlQciHHAy6qRyz3oBxOSY2bDo8IQasye0ioLVSG0stArrzUHHzLTd6C4fvbKW2RuuMByyMKS5Hfz7vXMByyMKS5Hfz8pKqUSi(7HhJpH8Vw5m4tpEjs4qH(spAS6ccp7fj2t(q9GP75IF4q9zsYMhwKHAy6qlfLSBNTluMKS5Hfze0ioLNsqAPjT8qSNl(Hd1NH(IY9FTM5O(OkrgQHPdTuuYUD2UqzOVOC)xRzoQpQsKrqJ4uEkbPLMIckkz3oBxOm0xuU)R1mh1hvjYiOrCkpLG0stikUSDqNx7cKKIoTPO(GiGp7pdm)D2E4YIof1IF4q9zCKeRLNbd1W0HwXYUD2UqzOVOC)xRzoQpQsKrqJ4uEkbPLM(5Hypx8dhQpd(0WLjOeYwpvGHAy6qlfLSBNTlug8PHltqjKTEQaJGgXP8ucslnffuuYUD2UqzWNgUmbLq26PcmcAeNYtjiT0eIIlBh051UajPOtBkQf)WH6Z4ijwlpdgQHPdTILD7SDHYGpnCzckHS1tfye0ioLNsqAPPFEi2Zf)WH6Z4ijwlpdgQHPdTuuYUD2UqzCKeRLNbJGgXPCiScslukBh051UajPOff1houFg8PHltqjKTEQad1W0HwkQpCO(m0xuU)R1mh1hvjYqnmDOLIs2Ern0Nbj0KlupOO(WH6ZkBh05WlQciHHAy6qRyz3oBxOSY2bDo8IQasye0ioLVSG0stArrzUHHzLTd6C4fvbKW2RuuMByyMKS5Hfz7vXMByyMKS5Hfz8pKqUSi(p(eY)ALZGp94LiHdf6lzpVNIz(3edOEW09gKlmDiZYZYG)HPdf)Hd1NXrsSwEgmudthAf)Hd1NbFA4YeuczRNkWqnmDOvSNYUD2UqzCKeRLNbJGHfAXYUD2UqzWNgUmbLq26PcmcAeNYtrBAkiTuuYUD2UqzCKeRLNbJGgXP8u0IMcsRyz3oBxOm4tdxMGsiB9ubgbnIt5ltBAkiTEiUSDqNx7cKqVSDqNx7cKWmcFhFc5FTYzWNE8sKWHc9LE0y1feE2lsSN8H6bt)dhQpJJKyT8myOgMo0k(dhQpd(0WLjOeYwpvGHAy6qRypLD7SDHY4ijwlpdgbdl0ILD7SDHYGpnCzckHS1tfye0ioLNI20uqAPOKD7SDHY4ijwlpdgbnIt5POfnfKwXYUD2UqzWNgUmbLq26PcmcAeNYxM20uqA9qCz7GoV2fiHEz7GoV2fiHze(o(mGXNq(xRCMaQij(MWPldNlhY)An7o(dvnmq6WNE8sKWHk)jN8Plcupy6LTd68AxGe6qKIYCddZkBh05WlQciHTxPOSO5ggMbFA4YeuczRNkW2Ruuw0CddZqFr5(VwZCuFuLiBVo(eY)ALZeqfjX3eouOVK3qtB7JxIeEUmmmqY4ti)RvotavKeFt4qH(s2Z7Py(BNdQhm9fTO5ggMbbBRGbQpBVk2Zf)WH6Z4ijwlpdgQHPdTuuMByyghjXA5zW2REi2ZfjXzZOxuFwyTCg67XFoffjoBg9I6ZcRLZonfT8NIIeNnJEr9zH1Yz7vpex2oOZRDbswMUFI9CXpCO(m4tdxMGsiB9ubgQHPdTuuYUD2UqzWNgUmbLq26PcmcAeNYtjiT0ue)9qSNl(Hd1NH(IY9FTM5O(OkrgQHPdTuuYUD2UqzOVOC)xRzoQpQsKrqJ4uEkbPLMI4pf1heb8z)zG5VZ2dxw09qSNYUD2UqzHxufovixqIVKrqJ4uofLSBNTluMKS5Hfze0ioL7X4ti)RvotavKeFt4qH(sLHHbsYnCUGeFjupy6KTIWnrazFjMncBEniHqRuuKTIWnrazEdvyhelpB0gO(BdXF4q9zOVOC)xRzoQpQsKHAy6qlfLS9IAOpZlQFj0eXYUD2UqzbVe1Cz4CDbJGgXP8u(jI)JpH8Vw5mburs8nHdf6lbbBRGbQpupy6lArZnmmdc2wbduF2EvS5ggMv2oOZHxufqcBVo(eY)ALZeqfjX3eouOVurajMB4CWlroupy6Ew2oOZRDbswMUFI)WH6ZqFr5(VwZCuFuLid1W0HwXw0CddZqFr5(VwZCuFuLiJGgXP8u(l2IMByyg6lk3)1AMJ6JQeze0ioLVSG0st)8y8jK)1kNjGksIVjCOqFjtxyXCdNHGn)pjc1dMEz7GoV2fizz60s8houFMPlSyUHZfK4lzOgMo0k2ZpCO(m4tdxMGsiB9ubgQHPdTITO5ggMbFA4YeuczRNkWiOrCkpLG0st)OO(WH6ZqFr5(VwZCuFuLid1W0HwXl(Hd1NbFA4YeuczRNkWqnmDOvSNw0CddZqFr5(VwZCuFuLiBVsrj72z7cLH(IY9FTM5O(OkrgbnIt5093dpgFc5FTYzcOIK4Bchk0xcc2wbduFOEW0x0IMByygeSTcgO(S9Q4pCO(mosI1YZGHAy6qRyplBh051UajPOlIyYwr4MiGSVeZgHWXFs8ipdbBRGbQpfvz7GoV2fijfD)8y8jK)1kNjGksIVjCOqFPIasm3W5GxICOEW09SSDqNx7cKq3FkQY2bDETlqYY09tSNYUD2UqzMUWI5godbB(FsKrqJ4uEkbPLM(rrzrZnmmd9fL7)AnZr9rvIS9kf1heb8z)zG5VZ2dxw0POSO5ggMbFA4YeuczRNkW2RE4HypxKeNnJEr9zH1YzOVh)5uuK4Sz0lQplSwo70u(5pffjoBg9I6ZcRLZ2REi2Zf)WH6ZqFr5(VwZCuFuLid1W0Hwkkz3oBxOm0xuU)R1mh1hvjYiOrCkpLiqKI6dIa(S)mW83z7Hll6Ei2Zf)WH6ZGpnCzckHS1tfyOgMo0srj72z7cLbFA4YeuczRNkWiOrCkpLiqKI6dIa(S)mW83z7Hll6Ei2tz3oBxOSWlQcNkKliXxYiOrCkNIs2TZ2fkts28WImcAeNY9y8jK)1kNjGksIVjCOqFjz4C5q(xRz3XFOQHbsh(0JxIeou5p5KpDrG6btVSDqNx7cKKIoTeBUHHzsYMhwKTxfBUHHzsYMhwKX)qc5YI4)4ti)RvotavKeFt4qH(sMUWI5godbB(FseQhm9Y2bDETlqYY0PLyzR299m031nri(RvgQHPdTIxu2Ern0N5f1VeAY4ti)RvotavKeFt4qH(sqW2kyG6d1dM(Iw0CddZGGTvWa1NTxhFc5FTYzcOIK4Bchk0xQmmmqsUHZfK4lhFc5FTYzcOIK4Bchk0xY0fwm3WziyZ)tIq9GPx2oOZRDbswMoTgFc5FTYzcOIK4Bchk0xsgoxoK)1A2D8hQAyG0Hp94LiHdv(to5txeOEW098dIa(SsmCFjBv(lt3p)POm3WWSWlQcNkKliXxY2RuuMByyMKS5Hfz7vkkZnmmdnwHMGHMx7cKW2REm(eY)ALZeqfjX3eouOVKKS5Hfjz(toirOEW0LD7SDHYKKnpSijZFYbjYKLbra5zysi)R1WLIUimrjef7zz7GoV2fizz6(rrv2oOZRDbswMoTel72z7cLz6clMB4meS5)jrgbnIt5PeKwA6hfvz7GoV2fiHoTfl72z7cLz6clMB4meS5)jrgbnIt5PeKwA6Nyz3oBxOmiyBfmq9ze0ioLNsqAPPFEm(eY)ALZeqfjX3eouOVKSvokjXFTc1dM(IYw5OKe)1kBVkMVIox(dIa(CM98EkM5Ftmsr3VXNq(xRCMaQij(MWHc9LKHZLd5FTMDh)HQggiD4tpEjs4JpH8Vw5mburs8nHdf6ljBLJss8xRq9GPVOSvokjXFTY2RJpH8Vw5mburs8nHdf6ljjBEyrsM)KdsC8jK)1kNjGksIVjCOqFPGidfZFtiO(JpH8Vw5mburs8nHdf6ljBLJss8xR1eViHFTwt3p)9te)fLIiAvtkcIEQaVMiApnnTKEAx6I2sddyaluId4mwBYpa4Mmarv2TZ2fkxuhabtB7JG2bWBdCaX(BJ4r7aKLHkGC24tA8uCa(r70WaGqT6fjpAhGOs2kc3ebKLMf1b89aevYwr4MiGS0md1W0HwrDaEkIVEWgFgFeTNMMwspTlDrBPHbmGfkXbCgRn5haCtgGOcF6XlrcxuhabtB7JG2bWBdCaX(BJ4r7aKLHkGC24tA8uCaIKggaeQvVi5r7aevYwr4MiGS0SOoGVhGOs2kc3ebKLMzOgMo0kQdWtr81d24tA8uCa0onmaiuRErYJ2bKCgqObWHw)W3baHDaFpG04ogG98E8R1b0Rij(MmapxYJb4Pi(6bB8jnEkoaiMggaeQvVi5r7asodi0a4qRF47aGWoGVhqAChdWEEp(16a6vKeFtgGNl5Xa8ueF9Gn(m(iApnnTKEAx6I2sddyaluId4mwBYpa4MmarvavKeFt4I6aiyABFe0oaEBGdi2FBepAhGSmubKZgFsJNIdG2PHbaHA1lsE0oarLSveUjcilnlQd47biQKTIWnrazPzgQHPdTI6a8ueF9Gn(KgpfhaTtddac1QxK8ODaIkzRiCteqwAwuhW3dqujBfHBIaYsZmudthAf1b4Pi(6bB8jnEkoarpnmaiuRErYJ2biQKTIWnrazPzrDaFparLSveUjcilnZqnmDOvuhGNI4RhSXNXN0oJ1M8ODaqCaH8VwhG74pNn(utI9x2KAsYzaHQjUJ)86c1elchB3xxOMUi1fQjH8VwRje0CdjwtqnmDOTsJ6xt3V6c1eudthAR0OMeY)ATMidNlhY)An7o(xtCh)ZAyG1ez3oBxO86xtNw1fQjOgMo0wPrnjK)1AnrgoxoK)1A2D8VM4o(N1WaRjcOIK4BcV(1VMSsqzBygFDHA6IuxOMeY)ATMS2)1Anb1W0H2knQFnD)Qlutc5FTwtmDiNFQqUHZ8THbsQjOgMo0wPr9RPtR6c1Kq(xR1ethY5NkKB4CS)THwtqnmDOTsJ6xtN21fQjH8VwRjMoKZpvi3W5ItFKutqnmDOTsJ6xthI1fQjH8VwRjMoKZpvi3Wz(k5uHAcQHPdTvAu)A6II6c1eudthAR0OMij3JKlQjF4q9zWNgUmbLq26PcmudthAhG4b8Hd1NXrsSwEgmudthARjH8VwRjbrgkM)Mqq9RF9RjcOIK4BcVUqnDrQlutqnmDOTsJAIKCpsUOMu2oOZRDbsga9baXbqrnaZnmmRSDqNdVOkGe2EDauudWIMByyg8PHltqjKTEQaBVoakQbyrZnmmd9fL7)AnZr9rvIS9AnH)Kt(10fPMeY)ATMidNlhY)An7o(xtCh)ZAyG1e4tpEjs41VMUF1fQjH8VwRjEdnTTpEjs45YWWaj1eudthAR0O(10PvDHAcQHPdTvAutKK7rYf1KfhGfn3WWmiyBfmq9z71biEaEoGfhWhouFghjXA5zWqnmDODauudWCddZ4ijwlpd2EDaEmaXdWZbS4aiXzZOxuFwyTCg67XF(aOOgajoBg9I6ZcRLZoDaPgaT8FauudGeNnJEr9zH1Yz71b4XaepGY2bDETlqYawM(a8BaIhGNdyXb8Hd1NbFA4YeuczRNkWqnmDODauudq2TZ2fkd(0WLjOeYwpvGrqJ4u(asnabPDa0CaI4)a8yaIhGNdyXb8Hd1NH(IY9FTM5O(OkrgQHPdTdGIAaYUD2UqzOVOC)xRzoQpQsKrqJ4u(asnabPDa0CaI4)aOOgWheb8z)zG5VZ2dhWYdq0hGhdq8a8CaYUD2UqzHxufovixqIVKrqJ4u(aOOgGSBNTluMKS5Hfze0ioLpapQjH8VwRj2Z7Py(BNR(10PDDHAcQHPdTvAutKK7rYf1eYwr4MiGSVeZgHnVgKqOvgQHPdTdGIAaKTIWnrazEdvyhelpB0gO(BdgQHPdTdq8a(WH6ZqFr5(VwZCuFuLid1W0H2bqrnaz7f1qFMxu)sOjdq8aKD7SDHYcEjQ5YW56cgbnIt5di1a8te)RjH8VwRjLHHbsYnCUGeFz9RPdX6c1eudthAR0OMij3JKlQjloalAUHHzqW2kyG6Z2Rdq8am3WWSY2bDo8IQasy71Asi)R1AceSTcgO(1VMUOOUqnb1W0H2knQjsY9i5IAINdOSDqNx7cKmGLPpa)gG4b8Hd1NH(IY9FTM5O(OkrgQHPdTdq8aSO5ggMH(IY9FTM5O(OkrgbnIt5di1a8FaIhGfn3WWm0xuU)R1mh1hvjYiOrCkFalpabPDa0Ca(napQjH8VwRjfbKyUHZbVe51VMUOSUqnb1W0H2knQjsY9i5IAsz7GoV2fizaltFa0AaIhWhouFMPlSyUHZfK4lzOgMo0oaXdWZb8Hd1NbFA4YeuczRNkWqnmDODaIhGfn3WWm4tdxMGsiB9ubgbnIt5di1aeK2bqZb43aOOgWhouFg6lk3)1AMJ6JQezOgMo0oaXdyXb8Hd1NbFA4YeuczRNkWqnmDODaIhGNdWIMByyg6lk3)1AMJ6JQez71bqrnaz3oBxOm0xuU)R1mh1hvjYiOrCkFa0hG)dWJb4rnjK)1AnX0fwm3WziyZ)tI1VMUOxxOMGAy6qBLg1ej5EKCrnzXbyrZnmmdc2wbduF2EDaIhWhouFghjXA5zWqnmDODaIhGNdOSDqNx7cKmGu0hGidq8aiBfHBIaY(smBech)jXJ8meSTcgO(mudthAhaf1akBh051Uajdif9b43a8OMeY)ATMabBRGbQF9RPlAvxOMGAy6qBLg1ej5EKCrnXZbu2oOZRDbsga9b4)aOOgqz7GoV2fizaltFa(naXdWZbi72z7cLz6clMB4meS5)jrgbnIt5di1aeK2bqZb43aOOgGfn3WWm0xuU)R1mh1hvjY2RdGIAaFqeWN9NbM)oBpCalparFauudWIMByyg8PHltqjKTEQaBVoapgGhdq8a8CaloasC2m6f1NfwlNH(E8NpakQbqIZMrVO(SWA5SthqQb4N)dGIAaK4Sz0lQplSwoBVoapgG4b45awCaF4q9zOVOC)xRzoQpQsKHAy6q7aOOgGSBNTlug6lk3)1AMJ6JQeze0ioLpGudqeioakQb8braF2Fgy(7S9WbS8ae9b4XaepaphWId4dhQpd(0WLjOeYwpvGHAy6q7aOOgGSBNTlug8PHltqjKTEQaJGgXP8bKAaIaXbqrnGpic4Z(ZaZFNThoGLhGOpapgG4b45aKD7SDHYcVOkCQqUGeFjJGgXP8bqrnaz3oBxOmjzZdlYiOrCkFaEutc5FTwtkciXCdNdEjYRFnDr8VUqnb1W0H2knQjsY9i5IAsz7GoV2fizaPOpaAnaXdWCddZKKnpSiBVoaXdWCddZKKnpSiJ)HeYbS8aeX)Ac)jN8RPlsnjK)1AnrgoxoK)1A2D8VM4o(N1WaRjWNE8sKWRFnDrePUqnb1W0H2knQjsY9i5IAsz7GoV2fizaltFa0AaIhGSv7(Eg676Mie)1kd1W0H2biEaloaz7f1qFMxu)sOj1Kq(xR1etxyXCdNHGn)pjw)A6I4xDHAcQHPdTvAutKK7rYf1KfhGfn3WWmiyBfmq9z71Asi)R1AceSTcgO(1VMUi0QUqnjK)1AnPmmmqsUHZfK4lRjOgMo0wPr9RPlcTRlutqnmDOTsJAIKCpsUOMu2oOZRDbsgWY0haTQjH8VwRjMUWI5godbB(FsS(10fbI1fQjOgMo0wPrnrsUhjxut8CaFqeWNvIH7lzRYFaltFa(5)aOOgG5ggMfErv4uHCbj(s2EDauudWCddZKKnpSiBVoakQbyUHHzOXk0em08AxGe2EDaEut4p5KFnDrQjH8VwRjYW5YH8VwZUJ)1e3X)Sggynb(0JxIeE9RPlIOOUqnb1W0H2knQjsY9i5IAISBNTluMKS5Hfjz(toirMSmicipdtc5FTgUbKI(aeHjkH4aepaphqz7GoV2fizaltFa(nakQbu2oOZRDbsgWY0haTgG4bi72z7cLz6clMB4meS5)jrgbnIt5di1aeK2bqZb43aOOgqz7GoV2fiza0haThG4bi72z7cLz6clMB4meS5)jrgbnIt5di1aeK2bqZb43aepaz3oBxOmiyBfmq9ze0ioLpGudqqAhanhGFdWJAsi)R1AIKS5Hfjz(toiX6xtxerzDHAcQHPdTvAutKK7rYf1KfhGSvokjXFTY2Rdq8a4ROZL)GiGpNzpVNIz(3eJbKI(a8RMeY)ATMiBLJss8xR1VMUiIEDHAcQHPdTvAutc5FTwtKHZLd5FTMDh)RjUJ)znmWAc8PhVej86xtxerR6c1eudthAR0OMij3JKlQjloazRCusI)ALTxRjH8VwRjYw5OKe)1A9RP7N)1fQjH8VwRjsYMhwKK5p5GeRjOgMo0wPr9RP7Ni1fQjH8VwRjbrgkM)Mqq9RjOgMo0wPr9RP7NF1fQjH8VwRjYw5OKe)1Anb1W0H2knQF9RjWNE8sKWRlutxK6c1eudthAR0OM0R1eo(1Kq(xR1eVb5cthwt8gUnwt4ROZL)GiGpNzpVNIz(3eJbqFa(naXdyXb45aiBfHBIaYGpnCzViXEYNHAy6q7aepGpCO(mYju(yV5zViXEYNHAy6q7aepazR299ShnwDbHN9EQ9KXFTYqnmDODaEmakQbWxrNl)braFoZEEpfZ8Vjgdi1a8BauudWCddZqJvOjyO51UajS96aepalAUHHzqW2kyG6ZSDHoaXdWCddZSN3tX86MS2CKz7cTM4niznmWAILNLb)dthw)A6(vxOMGAy6qBLg1ej5EKCrnXZbi72z7cLfErv4uHCbj(sgbnIt5di1aebIdGIAaYUD2UqzsYMhwKrqJ4u(asnarG4aOOgWhouFg8PHltqjKTEQad1W0H2b4XaepaphWId4dhQpd(0WLjOeYwpvGHAy6q7aOOgGSBNTlug8PHltqjKTEQaJGgXP8bKAa(5)aGYaeK2bqZbqRbqrnaz3oBxOm4tdxMGsiB9ubgbnIt5dyz6dqqAhanhaTgG4b45awCaK4Sz0lQplSwod994pFauudGeNnJEr9zH1YzNoGudG2(pakQbqIZMrVO(SWA5SthWYdqqAhaf1aiXzZOxuFwyTC2EDaEmapgG4b45awCaF4q9zOVOC)xRzoQpQsKHAy6q7aOOgGSBNTlug6lk3)1AMJ6JQeze0ioLpGudGwqCauudq2TZ2fkd9fL7)AnZr9rvImcAeNYhWY0hGG0oaAoaAnakQb8Hd1NbFA4YeuczRNkWqnmDODaEmaXdWZbS4aKTxud9zqcn5cDauudq2TZ2fkZEEpfZF7CmcAeNYhqQbqBioakQbi72z7cLzpVNI5VDogbnIt5dy5biAnapgaf1amBoFaIha8ju(zcAeNYhWYdqeioaXda(ek)mbnIt5di1aGynjK)1AnHJKyT8mQFnDAvxOMGAy6qBLg1ej5EKCrnXZbyUHHzsYMhwKz7cDaIhGSBNTluMKS5Hfze0ioLpGudqe)haf1am3WWmjzZdlY4FiHCaPOpaAnakQbi72z7cLfErv4uHCbj(sgbnIt5di1aeX)b4XaepaphWId4dhQpd(0WLjOeYwpvGHAy6q7aOOgGSBNTlug8PHltqjKTEQaJGgXP8bKAaI4)a8yaIhWheb8z)zG5VZ2dhqQbi61Kq(xR1e0xuU)R1mh1hvjw)A60UUqnb1W0H2knQjsY9i5IAI3GCHPdzwEwg8pmD4aepGfhG5ggM5n002(4LiHNldddKW2Rdq8a8CaEoGfhWhouFMKS5HfzOgMo0oakQbi72z7cLjjBEyrgbnIt5di1aeK2bqZbqRb4XaepaphWId4dhQpd9fL7)AnZr9rvImudthAhaf1aKD7SDHYqFr5(VwZCuFuLiJGgXP8bKAacs7aO5aefdGIAaYUD2UqzOVOC)xRzoQpQsKrqJ4u(asnabPDa0CaqCaIhqz7GoV2fizaPOpaApakQb8braF2Fgy(7S9WbS8ae9bqrnGfhWhouFghjXA5zWqnmDODaIhGSBNTlug6lk3)1AMJ6JQeze0ioLpGudqqAhanhGFdWJbiEaEoGfhWhouFg8PHltqjKTEQad1W0H2bqrnaz3oBxOm4tdxMGsiB9ubgbnIt5di1aeK2bqZbikgaf1aKD7SDHYGpnCzckHS1tfye0ioLpGudqqAhanhaehG4bu2oOZRDbsgqk6dG2dGIAaloGpCO(mosI1YZGHAy6q7aepaz3oBxOm4tdxMGsiB9ubgbnIt5di1aeK2bqZb43a8yaIhGNdyXb8Hd1NXrsSwEgmudthAhaf1aKD7SDHY4ijwlpdgbnIt5dyPbiiTdakdOSDqNx7cKmGudGwdGIAaF4q9zWNgUmbLq26PcmudthAhaf1a(WH6ZqFr5(VwZCuFuLid1W0H2bqrnaz7f1qFgKqtUqhGhdGIAaEoGpCO(SY2bDo8IQasyOgMo0oaXdq2TZ2fkRSDqNdVOkGegbnIt5dy5biiTdGMdGwdGIAaMByywz7GohErvajS96aOOgG5ggMjjBEyr2EDaIhG5ggMjjBEyrg)djKdy5biI)dWJb4rnjK)1AnXEEpfZ8Vjg1VMoeRlutqnmDOTsJAIKCpsUOM45awCaF4q9zsYMhwKHAy6q7aOOgGSBNTluMKS5Hfze0ioLpGudqqAhanhaTgGhdq8a8CaloGpCO(m0xuU)R1mh1hvjYqnmDODauudq2TZ2fkd9fL7)AnZr9rvImcAeNYhqQbiiTdGMdqumakQbi72z7cLH(IY9FTM5O(OkrgbnIt5di1aeK2bqZbaXbiEaLTd68AxGKbKI(aO9aOOgWheb8z)zG5VZ2dhWYdq0haf1awCaF4q9zCKeRLNbd1W0H2biEaYUD2UqzOVOC)xRzoQpQsKrqJ4u(asnabPDa0Ca(napgG4b45awCaF4q9zWNgUmbLq26PcmudthAhaf1aKD7SDHYGpnCzckHS1tfye0ioLpGudqqAhanhGOyauudq2TZ2fkd(0WLjOeYwpvGrqJ4u(asnabPDa0CaqCaIhqz7GoV2fizaPOpaApakQbS4a(WH6Z4ijwlpdgQHPdTdq8aKD7SDHYGpnCzckHS1tfye0ioLpGudqqAhanhGFdWJbiEaEoGfhWhouFghjXA5zWqnmDODauudq2TZ2fkJJKyT8mye0ioLpGLgGG0oaOmGY2bDETlqYasnaAnakQb8Hd1NbFA4YeuczRNkWqnmDODauud4dhQpd9fL7)AnZr9rvImudthAhaf1aKTxud9zqcn5cDaEmakQb8Hd1Nv2oOZHxufqcd1W0H2biEaYUD2UqzLTd6C4fvbKWiOrCkFalpabPDa0Ca0AauudWCddZkBh05WlQciHTxhaf1am3WWmjzZdlY2Rdq8am3WWmjzZdlY4FiHCalpar8VMeY)ATM8OXQli8SxKyp5x)A6II6c1eudthAR0OMij3JKlQjEdYfMoKz5zzW)W0Hdq8a(WH6Z4ijwlpdgQHPdTdq8a(WH6ZGpnCzckHS1tfyOgMo0oaXdWZbi72z7cLXrsSwEgmcgwOhG4bi72z7cLbFA4YeuczRNkWiOrCkFaPgaThanhGG0oakQbi72z7cLXrsSwEgmcAeNYhqQbqRbqZbiiTdq8aKD7SDHYGpnCzckHS1tfye0ioLpGLhaThanhGG0oapgG4bu2oOZRDbsga9bu2oOZRDbsygHV1Kq(xR1e759umZ)Myu)A6IY6c1eudthAR0OMij3JKlQjF4q9zCKeRLNbd1W0H2biEaF4q9zWNgUmbLq26PcmudthAhG4b45aKD7SDHY4ijwlpdgbdl0dq8aKD7SDHYGpnCzckHS1tfye0ioLpGudG2dGMdqqAhaf1aKD7SDHY4ijwlpdgbnIt5di1aO1aO5aeK2biEaYUD2UqzWNgUmbLq26PcmcAeNYhWYdG2dGMdqqAhGhdq8akBh051UajdG(akBh051UajmJW3Asi)R1AYJgRUGWZErI9KF9RFnr2TZ2fkVUqnDrQlutqnmDOTsJAIKCpsUOMyUHHzHxufovixqIVKTxhaf1am3WWmjzZdlY2Rdq8am3WWmjzZdlY4FiHCa0hGi(pakQby2C(aepa4tO8Ze0ioLpGLhGFqSMeY)ATMS2)1A9RP7xDHAcQHPdTvAutKK7rYf1e(k6C5pic4ZzUtO85ziyBfmq9hqk6dWVbqrnGfhajoBg9I6ZcRLZqFp(Zhaf1aiXzZOxuFwyTC2Pdi1aeLqCauudGeNnJEr9zH1Yz71Asi)R1AI7ekFEgc2wbdu)6xtNw1fQjOgMo0wPrnrsUhjxutm3WWSWlQcNkKliXxY2RdGIAaMByyMKS5Hfz71biEaMByyMKS5Hfz8pKqoa6dqe)RjH8VwRjWhbnDDBRFnDAxxOMGAy6qBLg1ej5EKCrnXZbS4a(WH6ZqFr5(VwZCuFuLid1W0H2bqrnaz3oBxOm0xuU)R1mh1hvjYiOrCkFalpai63a8yaIha8ju(zcAeNYhqQbiceRjH8VwRj8YdD2CdN9IQagQeRFnDiwxOMeY)ATMy6qo)uHCdN5BddKutqnmDOTsJ6xtxuuxOMeY)ATMy6qo)uHCdNJ9Vn0AcQHPdTvAu)A6IY6c1Kq(xR1ethY5NkKB4CXPpsQjOgMo0wPr9RPl61fQjH8VwRjMoKZpvi3Wz(k5uHAcQHPdTvAu)A6Iw1fQjOgMo0wPrnjK)1An5uUKS)W0H502o0FBKTO3tI1ej5EKCrnXCddZcVOkCQqUGeFjBVoakQbyUHHzsYMhwKTxhG4byUHHzsYMhwKX)qc5aOpar8FauudWS58biEaWNq5NjOrCkFalpaA5FnrddSMCkxs2Fy6WCABh6VnYw07jX6xtxe)RlutqnmDOTsJAsi)R1As7fjfLOZ4uH8AxGKSKan)dxnrsUhjxutm3WWSWlQcNkKliXxY2RdGIAaMByyMKS5Hfz71biEaMByyMKS5Hfz8pKqoa6dqe)haf1amBoFaIha8ju(zcAeNYhWYdqeiwt0WaRjTxKuuIoJtfYRDbsYsc08pC1VMUiIuxOMGAy6qBLg1Kq(xR1eBqG0OBnBrjKzVnjK3dDnrsUhjxutm3WWSWlQcNkKliXxY2RdGIAaMByyMKS5Hfz71biEaMByyMKS5Hfz8pKqoa6dqe)haf1amBoFaIha8ju(zcAeNYhWYdWp)RjAyG1eBqG0OBnBrjKzVnjK3dD9RPlIF1fQjOgMo0wPrnjK)1AnXiKHjbZ8se)SXMFYAIKCpsUOMyUHHzHxufovixqIVKTxhaf1am3WWmjzZdlY2Rdq8am3WWmjzZdlY4FiHCa0hGi(pakQby2C(aepa4tO8Ze0ioLpGLhGF(xt0WaRjgHmmjyMxI4Nn28tw)A6IqR6c1eudthAR0OMOHbwtSemSWhbZErohD1Kq(xR1elbdl8rWSxKZrx9RPlcTRlutqnmDOTsJAIggynHd52bjs45ItfQjH8VwRjCi3oircpxCQq9RPlceRlutqnmDOTsJAIggynrGCgzzBrFRjH8VwRjcKZilBl6B9RPlIOOUqnb1W0H2knQjAyG1ed0OjqNB48AW)m)uEnjK)1AnXanAc05goVg8pZpLx)A6IikRlutqnmDOTsJAIggynHVgemBGXNl7gYAsi)R1AcFniy2aJpx2nK1VMUiIEDHAcQHPdTvAut0WaRj8W5neqBgEZVwZHXQ7GpKutc5FTwt4HZBiG2m8MFTMdJv3bFiP(10fr0QUqnb1W0H2knQjH8VwRjBvwgNI2SGlSx8nHNndRaMB4mmsA59qxtKK7rYf1eZnmml8IQWPc5cs8LS96aOOgG5ggMjjBEyr2EDaIhG5ggMjjBEyrg)djKdif9biI)dGIAaYUD2UqzHxufovixqIVKrqJ4u(asnaAdXbqrnaz3oBxOmjzZdlYiOrCkFaPgaTHynrddSMSvzzCkAZcUWEX3eE2mScyUHZWiPL3dD9RP7N)1fQjOgMo0wPrnjK)1AnzRYY4u0Md(6rc95zZWkG5godJKwEp01ej5EKCrnXCddZcVOkCQqUGeFjBVoakQbyUHHzsYMhwKTxhG4byUHHzsYMhwKX)qc5asrFaI4)aOOgGSBNTluw4fvHtfYfK4lze0ioLpGudG2qCauudq2TZ2fkts28WImcAeNYhqQbqBiwt0WaRjBvwgNI2CWxpsOppBgwbm3WzyK0Y7HU(109tK6c1eudthAR0OMeY)ATMWpfE7YcUWEX3eE2mScyUHZWiPL3dDnrsUhjxutm3WWSWlQcNkKliXxY2RdGIAaMByyMKS5Hfz71biEaMByyMKS5Hfz8pKqoGu0hGi(pakQbi72z7cLfErv4uHCbj(sgbnIt5di1aOnehaf1aKD7SDHYKKnpSiJGgXP8bKAa0gI1enmWAc)u4Tll4c7fFt4zZWkG5godJKwEp01VMUF(vxOMGAy6qBLg1Kq(xR1e(PWBxo4Rhj0NNndRaMB4mmsA59qxtKK7rYf1eZnmml8IQWPc5cs8LS96aOOgG5ggMjjBEyr2EDaIhG5ggMjjBEyrg)djKdif9biI)dGIAaYUD2UqzHxufovixqIVKrqJ4u(asnaAdXbqrnaz3oBxOmjzZdlYiOrCkFaPgaTHynrddSMWpfE7YbF9iH(8SzyfWCdNHrslVh66xt3pAvxOMGAy6qBLg1ej5EKCrnXCddZcVOkCQqUGeFjBVoakQbyUHHzsYMhwKTxhG4byUHHzsYMhwKX)qc5asrFaI4FnjK)1AnzZX89ObV(109J21fQjOgMo0wPrnrsUhjxut8CaLTd68AxGKbKI(aO9aepG)mWbS8aG4aOOgqz7GoV2fizaPOpaAnaXdWZb8NboGudaIdGIAaKTIWnrazFjMncHJ)K4rEgc2wbduFgQHPdTdWJbqrnGpCO(SY2bDo8IQasyOgMo0oaXdq2TZ2fkRSDqNdVOkGegbnIt5dG(a8FaEmaXdWZbS4a(WH6Z4ijwlpdgQHPdTdGIAaYUD2UqzCKeRLNbJGgXP8bKAa(pakQb8Hd1NXdv(h8H2Cbj(sgQHPdTdWJAsi)R1As4fvHtfYfK4lRFnD)GyDHAcQHPdTvAutKK7rYf1KY2bDETlqYasrFa0EaIhWFg4awEaqCauudOSDqNx7cKmGu0haTgG4b8NboGudaIdGIAaF4q9zLTd6C4fvbKWqnmDODaIhGSBNTluwz7GohErvajmcAeNYha9b4FnjK)1Anrs28WI1VMUFII6c1Kq(xR1KGxIAUmCUUOMGAy6qBLg1VMUFIY6c1eudthAR0OMij3JKlQj)zG5VZLRcdG(a8FaIhGNdWCddZcVOkCQqUGeFjBVoakQbyUHHzsYMhwKTxhaf1am3WWSWlQcNkKliXxYSDHoaXdq2TZ2fkl8IQWPc5cs8LmcAeNYhqQbqB)haf1am3WWmjzZdlYSDHoaXdq2TZ2fkts28WImcAeNYhqQbqB)hGh1Kq(xR1KY2bDo8IQasQFnD)e96c1eudthAR0OMij3JKlQjEoGY2bDETlqYasrFa0EaIhWFg4awEaI(aOOgqz7GoV2fizaPOpaAnaXd4pdCaPOparFaEmaXdq2TZ2fkl8IQWPc5cs8LmcAeNYhqQbiiTdq8a(ZaZFNlxfga9b4)aepaphWId4dhQpJJKyT8myOgMo0oakQbyUHHzCKeRLNbBVoapgG4b45awCaK4Sz0lQplSwod994pFauudGeNnJEr9zH1Yz71bqrnasC2m6f1NfwlND6asnaA7)a8OMeY)ATMaFA4YeuczRNku)6x)6x)Af]] )


end
