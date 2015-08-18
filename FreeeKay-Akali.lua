local supportedChamp  	= nil
local QRange 			= 600
local WRange 			= 700
local ERange 			= 325
local RRange			= 700
local igniteRange		= 600
local tdis 				= nil
local mdis 				= nil
local BilgewaterCutlass = 3144
local HextechGunblade   = 3146
local ZhonyasHourglass	= 3157
local RegenerationPotion= 2003
local IgniteDamageEnough= false
local RStacks 			= 0
local qkill 			= nil
local potDelayFunction  = true
local Recall 			= false
local IgniteReady		= nil

local version 			= 1.021
local AUTOUPDATE 		= true
local SCRIPT_NAME		= "FreeeKay-Akali"
local scriptName		= "FreeeKay Akali"
local SCRIPT_HOSTSITE	= "raw.github.com"
local SCRIPT_HOSTNAME	= "/vanmancool/Lua-Scripts/master/"
local SOURCELIB_URL 	= "https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua"
local SOURCELIB_PATH 	= LIB_PATH.."SourceLib.lua"
local SXORBWALKLIB_URL	= "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua"
local SXORBWALKLIB_PATH	= LIB_PATH.."SxOrbWalk.lua"
local SxOrbWalkDownload = nil

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

function OnLoad()
	if myHero.charName == "Akali" then
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

		if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
			require ("SxOrbWalk")
			SxOrb:LoadToMenu()
			SxOrbWalkDownload = true
				else
			print ("<font color=\"#BF00FF\"><b>You need SxOrbWalk, downloading it now.</font></b>")
			DownloadFile(SXORBWALKLIB_URL, SXORBWALKLIB_PATH, function() print("<font color=\"#BF00FF\"><b>SxOrbWalk downloaded!</font></b>") end)
			SxOrbWalkDownload = false
		end

		if SxOrbWalkDownload == false then
			 print("<font color=\"#BF00FF\"><b>Required librarys downloaded, press F9 twice to reload!</font></b>")
		end

		if  SxOrbWalkDownload == true then
			print("<font color=\"#BF00FF\"><b>Loaded Menu!</font></b>")
		end

		Config = scriptConfig(scriptName.." by Vanmancool", scriptName)

		Config:addParam("space", "", SCRIPT_PARAM_INFO, "")
		Config:addParam("version", "[WIP] Current Version: ", SCRIPT_PARAM_INFO, version)
		Config:addParam("author", "FreeeKay Scripts by Vanmancool", SCRIPT_PARAM_INFO, "")

		Config:addSubMenu("Akali Combo Settings", "comboMenu")
		Config.comboMenu:addParam("comboQ", "Enable Q on Combo", SCRIPT_PARAM_ONOFF, true)
		Config.comboMenu:addParam("comboE", "Enable E on Combo", SCRIPT_PARAM_ONOFF, true)
		Config.comboMenu:addParam("comboR", "Enable R on Combo", SCRIPT_PARAM_ONOFF, true)
		Config.comboMenu:addParam("combominionR", "R to Minion to get to Champion", SCRIPT_PARAM_ONOFF, true)
		Config.comboMenu:addParam("experimental", "Experimental", SCRIPT_PARAM_INFO, "")

		Config:addSubMenu("Akali Lane Clear Settings", "laneclearMenu")
		Config.laneclearMenu:addParam("laneclearQ", "Enable Q on Lane Clear", SCRIPT_PARAM_ONOFF, true)
		Config.laneclearMenu:addParam("laneclearE", "Enable E on Lane Clear", SCRIPT_PARAM_ONOFF, true)

		Config:addSubMenu("Akali Harass Settings", "harassMenu")
		Config.harassMenu:addParam("harassQ", "Enable Q on Harass", SCRIPT_PARAM_ONOFF, true)
		Config.harassMenu:addParam("harassE", "Enable E on Harass", SCRIPT_PARAM_ONOFF, true)

		Config:addSubMenu("Item and Ignite Usage Settings", "items")
		Config.items:addParam("items", "Enable Item Usage", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("zhonyas", "Enable Auto Zhonyas", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("ignite", "Enable Ignite Usage", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("healpot", "Enable Health Pot Usage", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("safetyW", "Use W on Low Life", SCRIPT_PARAM_ONOFF, true)

		Config:addSubMenu("Kill Steal Setting", "kssettings")
		Config.kssettings:addParam("ksQ", "Kill Steal with Q", SCRIPT_PARAM_ONOFF, true)
		Config.kssettings:addParam("ksE", "Kill Steal with E", SCRIPT_PARAM_ONOFF, true)
		Config.kssettings:addParam("ksR", "Kill Steal with R", SCRIPT_PARAM_ONOFF, true)
		Config.kssettings:addParam("ksIgnite", "Kill Steal with Ignite", SCRIPT_PARAM_ONOFF, true)

		Config:addSubMenu("Key Settings", "keys")
		Config.keys:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		Config.keys:addParam("laneclear", "Lane Clear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		Config.keys:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		Config.keys:addParam("lasthit", "Last Hit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))

		Config:addSubMenu("Draw Settings", "draws")
		Config.draws:addParam("drawcircle", "Enable/Disable all Draws", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawcircleQ", "Enable/Disable Q Range", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawcircleW", "Enable/Disable W Range", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawcircleE", "Enable/Disable E Range", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawcircleR", "Enable/Disable R Range", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawignite", "Enable/Disable Ignite Draws", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawdmg", "Enable/Disable Damage Calculation Draws", SCRIPT_PARAM_ONOFF, true)


		TargetSelector = TargetSelector(TARGET_LOW_HP_PRIORITY, 1400)
		Config:addTS(TargetSelector)


		enemyMinions = minionManager(MINION_ENEMY, 900, myHero, MINION_SORT_MAXHEALTH_DEC)

		IgniteFind()
	end
end

function OnTick()
	if supportedChamp == true then
		ap = math.floor (myHero.ap + 0.5)
		ad = math.floor (myHero.totalDamage)

		TargetSelector:update()
		enemyMinions:update()
		target = TargetSelector.target
		Items()
		GetMinion()
		OnCombo()
		OnLaneClear()
		OnHarass()
		Ignite()
		DamageCalc()
	end
end

function OnCombo()

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end
	if ValidTarget(minion) then 
		mdis  = GetDistance(minion)
	end

	local QReady		= myHero:CanUseSpell(_Q)
	local WReady		= myHero:CanUseSpell(_W)
	local EReady		= myHero:CanUseSpell(_E)
	local RReady		= myHero:CanUseSpell(_R)

	if Config.keys.combo and ValidTarget(target) then
		for i, minion in pairs(enemyMinions.objects) do
		  	if minion ~= nil and ValidTarget(minion) and ValidTarget(target)then
		  		mdis  = GetDistance(minion)
		  		dashRange = minion:GetDistance(target)
		  		if mdis < RRange and  tdis > RRange and dashRange < RRange and mdis < tdis  and RReady then
		  			CastSpell(_R, minion)
		  		end
		  	end
		end
  		if QReady and Config.comboMenu.comboQ then
			if tdis < QRange then
				CastSpell(_Q, target)
			end
		end
		if RReady and Config.comboMenu.comboR then
			if tdis < RRange then
				CastSpell(_R, target)
			end
		end	
		if EReady and Config.comboMenu.comboE then
			if tdis < ERange then
				CastSpell(_E)
			end
		end
	end
end


function OnLaneClear()

	local QReady		= myHero:CanUseSpell(_Q)
	local EReady		= myHero:CanUseSpell(_E)

	for i, minion in pairs(enemyMinions.objects) do
  		if minion ~= nil and ValidTarget(minion, QRange) then
  		    if QReady and Config.laneclearMenu.laneclearQ and Config.keys.laneclear then
  		    	CastSpell(_Q, minion)
  		    end
		end
		if minion ~= nil and ValidTarget(minion, ERange) then
  		    if EReady and Config.laneclearMenu.laneclearE and Config.keys.laneclear then
  		    	CastSpell(_E, minion)
  		    end
  		end
  	end
end


function OnHarass()

	local QReady		= myHero:CanUseSpell(_Q)
	local EReady		= myHero:CanUseSpell(_E)

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end

	if Config.keys.harass and ValidTarget(target) then
		if QReady and Config.harassMenu.harassQ then
			if tdis < QRange then
				CastSpell(_Q, target)
			end
		end
		if EReady and Config.harassMenu.harassE then
			if tdis < ERange then
				CastSpell(_E)
			end
		end
  	end
end


function Ignite()

	if ignite ~= nil then
		IgniteReady	= myHero:CanUseSpell(ignite)
	end

	local IgniteDps			= 10 + (4 * myHero.level)
	local IgniteDamage		= 50 + (20 * myHero.level)

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end

	if ignite ~= nil and Config.items.ignite and Config.kssettings.ksIgnite and ValidTarget(target) then
		if IgniteReady and target.health < IgniteDamage and tdis < igniteRange then
			CastSpell(ignite, target)
		end
	end
end

function Items()

	myHeroPercent = myHero.maxHealth / 100 * 20
	myHeroHpPots = myHero.maxHealth / 100 * 50

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end

	if myHero.health < myHeroHpPots and Config.items.healpot and potDelayFunction == true then
		CastItem(RegenerationPotion)
	end

	if myHero.health < myHeroPercent and Config.items.safetyW and Recall == false then
		CastSpell(_W, myHero.x, myHero.z)
	end

    if myHero.health < myHeroPercent and Config.items.zhonyas then
		CastItem(ZhonyasHourglass)
	end

	if Config.keys.combo and Config.items.items and ValidTarget(target) then
		CastItem(BilgewaterCutlass, target)
		CastItem(HextechGunblade, target)
	end	
end


function IgniteFind()
		if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
			ignite = SUMMONER_1 
		else if myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
			ignite = SUMMONER_2 
		else 
			ignite = nil
		end
	end
end

function DamageCalc()

	local IgniteDamage		= 50 + (20 * myHero.level)

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end

	if myHero:GetSpellData(_Q).level > 0 then
		QDamage = 35 + (myHero:GetSpellData(_Q).level * 20 + ap * 0.4 + myHero:GetSpellData(_Q).level * 25 + ap * 0.5 + ad)
	else 
		QDamage = 0
	end
	if myHero:GetSpellData(_E).level > 0 then
		EDamage = 5 + (myHero:GetSpellData(_E).level * 25 + ad * 0.6 + ap * 0.4)
	else
		EDamage = 0
	end
	if myHero:GetSpellData(_R).level > 0 then
		RDamage = 25 + (myHero:GetSpellData(_R).level * 75 + ap * 0.5)
	else
		RDamage = 0
	end 

	allDmg = QDamage + EDamage + RDamage

--	print (QDamage+ EDamage + RDamage + IgniteDamage.. " Der aktuelle Schaden von allen Attacken")

--	print(QDamage + EDamage + RDamage + ad .. " Damage with One Autoattack")
--	print(ap .. " Abillity Power")
--	print(QDamage .. " Q Damage with Autoattack")
--	print(EDamage .. " E Damage")
--	print(RDamage .. " R Damage")

end


function OnApplyBuff(source, unit, buff)
	if unit and unit.isMe and buff.name == "RegenerationPotion" then
		potDelayFunction = false
	end
	if unit and unit.isMe and buff.name == "recall" then
		Recall = true
	end
end

function OnRemoveBuff(unit, buff)
    if unit and unit.isMe and buff.name == "RegenerationPotion" then
        potDelayFunction = true
    end
    if unit and unit.isMe and buff.name == "recall" then
		Recall = false
	end
end


function GetMinion()
	enemyMinions:update()
	for i, minion in pairs(enemyMinions.objects) do
		if minion ~= nil and ValidTarget(enemyMinions) and GetDistance(minion) <= RRange then
			print(enemyMinions)
			return minion
		end
	end
end


function OnDraw()
	if supportedChamp == true then
		if Config.draws.drawcircle and Config.draws.drawcircleQ then 
			DrawCircle(myHero.x, myHero.y, myHero.z, QRange, 0x111111)
		end
		if Config.draws.drawcircle and Config.draws.drawcircleW then 
			DrawCircle(myHero.x, myHero.y, myHero.z, WRange, 0x111111)
		end
		if Config.draws.drawcircle and Config.draws.drawcircleE then 
			DrawCircle(myHero.x, myHero.y, myHero.z, ERange, 0x111111)
		end
		if Config.draws.drawcircle and Config.draws.drawcircleR then 
			DrawCircle(myHero.x, myHero.y, myHero.z, RRange, 0x111111)
		end
	--	if Config.draws.drawcircle and qkill ~= nil and Config.draws.drawdmg then
	--		DrawText("Q Kills Him!", 15, 100, 200, 0xFFFFFF00)
	--	end
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
