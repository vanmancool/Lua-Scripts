local version 				= 1.005
local SCRIPT_NAME			= "FreeeKay-Leona"
local scriptName 			= "FreeeKay Leona"
local SCRIPT_HOSTSITE		= "raw.github.com"
local SCRIPT_HOSTNAME		= "/vanmancool/Lua-Scripts/master/"
local SOURCELIB_URL 		= "https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua"
local SOURCELIB_PATH 		= LIB_PATH.."SourceLib.lua"
local HPREDICTIONLIB_URL	= "https://raw.githubusercontent.com/BolHTTF/BoL/master/HTTF/Common/HPrediction.lua"
local HPREDICTIONLIB_PATH	= LIB_PATH.."HPrediction.lua"
local SXORBWALKLIB_URL		= "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua"
local SXORBWALKLIB_PATH		= LIB_PATH.."SxOrbWalk.lua"
local HPredictionDownload 	= nil
local SxOrbWalkDownload 	= nil


if FileExist(SOURCELIB_PATH) then
	require("SourceLib")
else
    DONLOADING_SOURCELIB = true
    DownloadFile(SOURCELIB_URL, SOURCELIB_PATH, function() print("Required libraries downloaded successfully, please reload") end)
end

if DOWNLOADING_SOURCELIB then print("Downloading required libraries, please wait...") return end

local RequireI = Require("SourceLib")
RequireI:Check()

if AUTOUPDATE then
     SourceUpdater(SCRIPT_NAME, version, SCRIPT_HOSTSITE, SCRIPT_HOSTNAME..SCRIPT_NAME..".lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, SCRIPT_HOSTNAME..SCRIPT_NAME..".version"):CheckUpdate()
end




local supportedChamp = nil







function OnLoad()
	if myHero.charName == "Leona" then
		supportedChamp = true

		print("<font color=\"#BF00FF\"><b>Hello and Welcome to: "..scriptName.." </font></b>")

		ItemNames				= {
			[3303]				= "ArchAngelsDummySpell",
			[3007]				= "ArchAngelsDummySpell",
			[3144]				= "BilgewaterCutlass",
			[3188]				= "ItemBlackfireTorch",
			[3153]				= "ItemSwordOfFeastAndFamine",
			[3405]				= "TrinketSweeperLvl1",
			[3411]				= "TrinketOrbLvl1",
			[3166]				= "TrinketTotemLvl1",
			[3450]				= "OdinTrinketRevive",
			[2041]				= "ItemCrystalFlask",
			[2054]				= "ItemKingPoroSnack",
			[2138]				= "ElixirOfIron",
			[2137]				= "ElixirOfRuin",
			[2139]				= "ElixirOfSorcery",
			[2140]				= "ElixirOfWrath",
			[3184]				= "OdinEntropicClaymore",
			[2050]				= "ItemMiniWard",
			[3401]				= "HealthBomb",
			[3363]				= "TrinketOrbLvl3",
			[3092]				= "ItemGlacialSpikeCast",
			[3460]				= "AscWarp",
			[3361]				= "TrinketTotemLvl3",
			[3362]				= "TrinketTotemLvl4",
			[3159]				= "HextechSweeper",
			[2051]				= "ItemHorn",
			[2003]				= "RegenerationPotion",
			[3146]				= "HextechGunblade",
			[3187]				= "HextechSweeper",
			[3190]				= "IronStylus",
			[2004]				= "FlaskOfCrystalWater",
			[3139]				= "ItemMercurial",
			[3222]				= "ItemMorellosBane",
			[3042]				= "Muramana",
			[3043]				= "Muramana",
			[3180]				= "OdynsVeil",
			[3056]				= "ItemFaithShaker",
			[2047]				= "OracleExtractSight",
			[3364]				= "TrinketSweeperLvl3",
			[2052]				= "ItemPoroSnack",
			[3140]				= "QuicksilverSash",
			[3143]				= "RanduinsOmen",
			[3074]				= "ItemTiamatCleave",
			[3800]				= "ItemRighteousGlory",
			[2045]				= "ItemGhostWard",
			[3342]				= "TrinketOrbLvl1",
			[3040]				= "ItemSeraphsEmbrace",
			[3048]				= "ItemSeraphsEmbrace",
			[2049]				= "ItemGhostWard",
			[3345]				= "OdinTrinketRevive",
			[2044]				= "SightWard",
			[3341]				= "TrinketSweeperLvl1",
			[3069]				= "shurelyascrest",
			[3599]				= "KalistaPSpellCast",
			[3185]				= "HextechSweeper",
			[3077]				= "ItemTiamatCleave",
			[2009]				= "ItemMiniRegenPotion",
			[2010]				= "ItemMiniRegenPotion",
			[3023]				= "ItemWraithCollar",
			[3290]				= "ItemWraithCollar",
			[2043]				= "VisionWard",
			[3340]				= "TrinketTotemLvl1",
			[3090]				= "ZhonyasHourglass",
			[3154]				= "wrigglelantern",
			[3142]				= "YoumusBlade",
			[3157]				= "ZhonyasHourglass",
			[3512]				= "ItemVoidGate",
			[3131]				= "ItemSoTD",
			[3137]				= "ItemDervishBlade",
			[3352]				= "RelicSpotter",
			[3350]				= "TrinketTotemLvl2",
		}
		
		_G.ITEM_1				= 06
		_G.ITEM_2				= 07
		_G.ITEM_3				= 08
		_G.ITEM_4				= 09
		_G.ITEM_5				= 10
		_G.ITEM_6				= 11
		_G.ITEM_7				= 12
		
		___GetInventorySlotItem	= rawget(_G, "GetInventorySlotItem")
		_G.GetInventorySlotItem	= GetSlotItem

		CustomOnLoad()

	else
		print("Your champion is not supported right now!")
		supportedChamp = false
	end
end


function CustomOnLoad()
	if supportedChamp == true then
		print("<font color=\"#BF00FF\"><b>Loading Menu... </font></b>")

		if FileExist(LIB_PATH .. "/HPrediction.lua") then
			require ("HPrediction")
			HPredictionDownload = true
		else
			print ("<font color=\"#BF00FF\"><b>You need HPrediction, download it now.</font></b>")
			DownloadFile(HPREDICTIONLIB_URL, HPREDICTIONLIB_PATH, function() print("<font color=\"#BF00FF\"><b>HPrediction downloaded!</font></b>") end)
			HPredictionDownload = false
		end

		if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
			require ("SxOrbWalk")
			SxOrb:LoadToMenu()
			SxOrbWalkDownload = true
				else
			print ("<font color=\"#BF00FF\"><b>You need SxOrbWalk, downloading it now.</font></b>")
			DownloadFile(SXORBWALKLIB_URL, SXORBWALKLIB_PATH, function() print("<font color=\"#BF00FF\"><b>SxOrbWalk downloaded!</font></b>") end)
			SxOrbWalkDownload = false
		end

		if HPredictionDownload == false or SxOrbWalkDownload == false then
			 print("<font color=\"#BF00FF\"><b>Required librarys downloaded, press F9 twice to reload!</font></b>")
		end

		if HPredictionDownload == true and SxOrbWalkDownload == true then
			print("<font color=\"#BF00FF\"><b>Finished Loading Menu!</font></b>")
		end

		Config = scriptConfig(scriptName.." by Vanmancool", scriptName)

		Config:addParam("space", "", SCRIPT_PARAM_INFO, "")
		Config:addParam("version", "[WIP] Current Version: ", SCRIPT_PARAM_INFO, version)
		Config:addParam("author", "FreeeKay Scripts by Vanmancool", SCRIPT_PARAM_INFO, "")

	end
end






















































































function GetSlotItem(id, unit)
	
	unit 		= unit or myHero

	if (not ItemNames[id]) then
		return ___GetInventorySlotItem(id, unit)
	end

	local name	= ItemNames[id]
	
	for slot = ITEM_1, ITEM_7 do
		local item = unit:GetSpellData(slot).name
		if ((#item > 0) and (item:lower() == name:lower())) then
			return slot
		end
	end
end
