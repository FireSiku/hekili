-- Hekili.lua
-- April 2014

local addon, ns = ...
Hekili = LibStub("AceAddon-3.0"):NewAddon( "Hekili", "AceConsole-3.0", "AceSerializer-3.0" )
Hekili.Version = GetAddOnMetadata("Hekili", "Version")

if Hekili.Version == ( "@" .. "project-version" .. "@" ) then Hekili.Version = "Development-" .. date("%Y%m%d" ) end

Hekili.AllowSimCImports = true

local format = string.format
local upper  = string.upper


Hekili.IsClassic = function() return ( WOW_PROJECT_ID == WOW_PROJECT_CLASSIC ) or ( WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC ) end
ns.PTR = select( 4, GetBuildInfo() ) > 90100


ns.Patrons = "Abom, Abra, Abuna, Aern, Aggronaught, akh270, Alasha, alcaras, Amera, ApexPlatypus, aphoenix, Archxlock, Aristocles, aro725, Artoo, Ash, av8ordoc, Battle Hermit VIA, Belatar, Borelia, Brangeddon, Bsirk/Kris, Cele, Chimmi, Coan, Cortland, Daz, DB, Der Baron, Dez, Drako, Enemy, Eryx, fuon, Garumako, Graemec, Grayscale, guhbjs, Hambrick, Hexel, Himea, Hollaputt, Hungrypilot, Ifor, Ingrathis, intheyear, Jacii, jawj, Jenkz, Katurn, Kingreboot, Kittykiller, Lagertha, Leorus, Loraniden, Lord Corn, Lovien, Manni, Mirando, mr. jing0, Mr_Hunter, MrBean73, mrminus, Muffin, Mumrikk, Nelix, neurolawl, Nighteyez, nomiss, nqrse, Orcodamus, Parameshvar, Rage, Ramen, Ramirez (Jon), Rebdull, Ridikulus0510, rockschtar, Roodie, Rusah, Samuraiwillz501, sarrge, Sarthol, Scerick, Sebstar, Seniroth, seriallos, Shakeykev, Shuck, Skeletor, Slem, Spaten, Spy, Srata, Stevi, Strozzy, Tekfire, Tevka, Theda99, Thordros, Tic[Ã ]sentence, Tobi, todd, Torsti, tsukari, Tyazrael, Ulti.DTY, Val (Valdrath), Vaxum, Vsmit, Wargus (Shagus), Weedwalker, WhoaIsJustin, Wonder, zab, Zarggg, and zarrin-zuljin"


do
    local cpuProfileDB = {}

    function Hekili:ProfileCPU( name, func )
        cpuProfileDB[ name ] = func
    end

	ns.cpuProfile = cpuProfileDB
	

	local frameProfileDB = {}

	function Hekili:ProfileFrame( name, f )
		frameProfileDB[ name ] = f
	end

	ns.frameProfile = frameProfileDB
end


ns.lib = {
    Format = {}
}


-- 04072017:  Let's go ahead and cache aura information to reduce overhead.
ns.auras = {
    target = {
        buff = {},
        debuff = {}
    },
    player = {
        buff = {},
        debuff = {}
    }
}

Hekili.Class = {
    specs = {},
    num = 0,

    file = "NONE",

	resources = {},
	resourceAuras = {},
    talents = {},
    pvptalents = {},
	auras = {},
	auraList = {},
    powers = {},
	gear = {},
	
	knownAuraAttributes = {},

    stateExprs = {},
    stateFuncs = {},
    stateTables = {},

	abilities = {},
	abilityByName = {},
    abilityList = {},
    itemList = {},
    itemMap = {},
    itemPack = {
        lists = {
            items = {}
        }
    },

    packs = {},

    pets = {},
    totems = {},

    potions = {},
    potionList = {},

	hooks = {},
    range = 8,
	settings = {},
    stances = {},
	toggles = {},
	variables = {},
}

Hekili.Scripts = {
    DB = {},
    Channels = {},
    PackInfo = {},
}

Hekili.State = {}

ns.hotkeys = {}
ns.keys = {}
ns.queue = {}
ns.targets = {}
ns.TTD = {}

ns.UI = {
    Displays = {},
    Buttons = {}
}

ns.debug = {}
ns.snapshots = {}


function Hekili:Query( ... )
	local output = ns

	for i = 1, select( '#', ... ) do
		output = output[ select( i, ... ) ]
    end

    return output
end


function Hekili:Run( ... )
	local n = select( "#", ... )
	local fn = select( n, ... )

	local func = ns

	for i = 1, fn - 1 do
		func = func[ select( i, ... ) ]
    end

    return func( select( fn, ... ) )
end


local debug = ns.debug
local active_debug
local current_display

local lastIndent = 0

function Hekili:SetupDebug( display )
    if not self.ActiveDebug then return end
    if not display then return end

    current_display = display

    debug[ current_display ] = debug[ current_display ] or {
        log = {},
        index = 1
    }
    active_debug = debug[ current_display ]
	active_debug.index = 1
	
	lastIndent = 0
	
	local pack = self.State.system.packName

    if not pack then return end
    
	self:Debug( "New Recommendations for [ %s ] requested at %s ( %.2f ); using %s( %s ) priority.", display, date( "%H:%M:%S"), GetTime(), self.DB.profile.packs[ pack ].builtIn and "built-in " or "", pack )
end


function Hekili:Debug( ... )
    if not self.ActiveDebug then return end
	if not active_debug then return end
	
	local indent, text = ...
	local start

	if type( indent ) ~= "number" then
		indent = lastIndent
		text = ...
		start = 2
	else
		lastIndent = indent
		start = 3
	end

	local prepend = format( indent > 0 and ( "%" .. ( indent * 4 ) .. "s" ) or "%s", "" )
	text = text:gsub("\n", "\n" .. prepend )

	active_debug.log[ active_debug.index ] = format( "%" .. ( indent > 0 and ( 4 * indent ) or "" ) .. "s" .. text, "", select( start, ... ) )
    active_debug.index = active_debug.index + 1
end


local snapshots = ns.snapshots

function Hekili:SaveDebugSnapshot( dispName )

    local snapped = false

	for k, v in pairs( debug ) do
		
		if dispName == nil or dispName == k then
			if not snapshots[ k ] then
				snapshots[ k ] = {}
			end

			for i = #v.log, v.index, -1 do
				v.log[ i ] = nil
			end

            -- Store aura data.
            local auraString = "\nplayer_buffs:"
            local now = GetTime()

            local class = Hekili.Class

            for i = 1, 40 do
                local name, _, count, debuffType, duration, expirationTime, source, _, _, spellId, canApplyAura, isBossDebuff, castByPlayer = UnitBuff( "player", i )

                if not name then break end

                auraString = format( "%s\n   %6d - %-40s - %3d - %-.2f", auraString, spellId, class.auras[ spellId ] and class.auras[ spellId ].key or ( "*" .. name ), count > 0 and count or 1, expirationTime > 0 and ( expirationTime - now ) or 3600 )
            end

            auraString = auraString .. "\n\nplayer_debuffs:"

            for i = 1, 40 do
                local name, _, count, debuffType, duration, expirationTime, source, _, _, spellId, canApplyAura, isBossDebuff, castByPlayer = UnitDebuff( "player", i )

                if not name then break end

                auraString = format( "%s\n   %6d - %-40s - %3d - %-.2f", auraString, spellId, class.auras[ spellId ] and class.auras[ spellId ].key or ( "*" .. name ), count > 0 and count or 1, expirationTime > 0 and ( expirationTime - now ) or 3600 )
            end


            if not UnitExists( "target" ) then
                auraString = auraString .. "\n\ntarget_auras:  target does not exist"
            else
                auraString = auraString .. "\n\ntarget_buffs:"
                
                for i = 1, 40 do
                    local name, _, count, debuffType, duration, expirationTime, source, _, _, spellId, canApplyAura, isBossDebuff, castByPlayer = UnitBuff( "target", i )
    
                    if not name then break end
    
                    auraString = format( "%s\n   %6d - %-40s - %3d - %-.2f", auraString, spellId, class.auras[ spellId ] and class.auras[ spellId ].key or ( "*" .. name ), count > 0 and count or 1, expirationTime > 0 and ( expirationTime - now ) or 3600 )
                end
    
                auraString = auraString .. "\n\ntarget_debuffs:"

                for i = 1, 40 do
                    local name, _, count, debuffType, duration, expirationTime, source, _, _, spellId, canApplyAura, isBossDebuff, castByPlayer = UnitDebuff( "target", i, "PLAYER" )
    
                    if not name then break end
    
                    auraString = format( "%s\n   %6d - %-40s - %3d - %-.2f", auraString, spellId, class.auras[ spellId ] and class.auras[ spellId ].key or ( "*" .. name ), count > 0 and count or 1, expirationTime > 0 and ( expirationTime - now ) or 3600 )
                end
            end

            auraString = auraString .. "\n\n"

            table.insert( v.log, 1, auraString )
            table.insert( v.log, 1, "targets:\n" .. Hekili.TargetDebug )
            table.insert( v.log, 1, self:GenerateProfile() )
            table.insert( snapshots[ k ], table.concat( v.log, "\n" ) )
            
            snapped = true
		end

    end

    if snapped and Hekili.DB.profile.screenshot then
        Screenshot()
        -- Don't need to print anything; WoW shows a "Screen Captured" message.
    end

    return snapped
end

Hekili.Snapshots = ns.snapshots



ns.Tooltip = CreateFrame( "GameTooltip", "HekiliTooltip", UIParent, "GameTooltipTemplate" )
