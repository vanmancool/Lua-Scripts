local version 			= 1.026
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

local supportedChamp	= nil
local getAaRange		= nil
local tdis 				= nil
local WRange 			= 500
local ItemTiamatCleave  = 3074
local ItemTiamatCleave	= 3077
local tiamatRange		= 380
local WRange 			= 480
local ERange 			= 1000
local potDelayFunction  = true
local Recall 			= false
local ignite 			= nil
local smite 			= nil
local igniteRange 		= 600
local smiteRange		= 675
local rIsActive 		= false



function OnLoad()
	if myHero.charName == "Rengar" then
		supportedChamp = true
		print("<font color=\"#BF00FF\"><b>[Freeekay Champion] Hello and Welcome to "..scriptName.."! </font></b>")

	ItemNames				= {
		[3144]				= "BilgewaterCutlass",
		[3153]				= "ItemSwordOfFeastAndFamine",
		[3405]				= "TrinketSweeperLvl1",
		[3166]				= "TrinketTotemLvl1",
		[3361]				= "TrinketTotemLvl3",
		[3362]				= "TrinketTotemLvl4",
		[2003]				= "RegenerationPotion",
		[3146]				= "HextechGunblade",
		[3187]				= "HextechSweeper",
		[3364]				= "TrinketSweeperLvl3",
		[3074]				= "ItemTiamatCleave",
		[3077]				= "ItemTiamatCleave",
		[3340]				= "TrinketTotemLvl1",
		[3090]				= "ZhonyasHourglass",
		[3142]				= "YoumusBlade",
		[3157]				= "ZhonyasHourglass",
		[3350]				= "TrinketTotemLvl2",
	}
	
			  
			    _G.ITEM_1 = 06
			    _G.ITEM_2 = 07
			    _G.ITEM_3 = 08
			    _G.ITEM_4 = 09
			    _G.ITEM_5 = 10
			    _G.ITEM_6 = 11
			    _G.ITEM_7 = 12
			    
			    ___GetInventorySlotItem = rawget(_G, "GetInventorySlotItem")
			    _G.GetInventorySlotItem = GetSlotItem

		require("SxOrbWalk")
		require("HPrediction")

		HP = HPrediction()
  		HP_E  = HPSkillshot({delay = 0, range = 1100, speed = 1800, type = "DelayLine", width = 90})

	Config = scriptConfig(scriptName.." by Vanmancool", scriptName)

		Config:addParam("space", "", SCRIPT_PARAM_INFO, "")
		Config:addParam("version", "[WIP] Current Version: ", SCRIPT_PARAM_INFO, version)
		Config:addParam("author", "FreeeKay Scripts by Vanmancool", SCRIPT_PARAM_INFO, "")

	Config:addSubMenu("Combo", "comboMenu")
		Config.comboMenu:addParam("ferocityUsage", "Combo Options", SCRIPT_PARAM_LIST, 1, { "Q", "W", "E" })
		Config.comboMenu:addParam("comboInfo", "Nothing for now...", SCRIPT_PARAM_INFO, "")
		Config.comboMenu:addParam("comboInfo", "Gimme some ideas :)...", SCRIPT_PARAM_INFO, "")


	Config:addSubMenu("Lane Clear", "laneclearMenu")
		Config.laneclearMenu:addParam("wToHealLaneClear", "Use W to heal in Lane Clear", SCRIPT_PARAM_ONOFF, true)
		Config.laneclearMenu:addParam("items", "Use Items in Lane Clear", SCRIPT_PARAM_ONOFF, true)
		Config.laneclearMenu:addParam("laneclearQ", "Use Q in Lane Clear", SCRIPT_PARAM_ONOFF, true)
		Config.laneclearMenu:addParam("laneclearW", "Use W in Lane Clear", SCRIPT_PARAM_ONOFF, true)
		Config.laneclearMenu:addParam("LaneclearE", "Use E in Lane Clear", SCRIPT_PARAM_ONOFF, true)

	Config:addSubMenu("Jungle Clear", "jungleclearMenu")
		Config.jungleclearMenu:addParam("ferocityUsageJungle", "Ferocity Usage in Jungle Clear", SCRIPT_PARAM_LIST, 1, { "Q", "W", "E" })
		Config.jungleclearMenu:addParam("items", "Use Items in Jungle Clear", SCRIPT_PARAM_ONOFF, true)
		Config.jungleclearMenu:addParam("jungleclearQ", "Use Q in Jungle Clear", SCRIPT_PARAM_ONOFF, true)
		Config.jungleclearMenu:addParam("jungleclearE", "Use W in Jungle Clear", SCRIPT_PARAM_ONOFF, true)
		Config.jungleclearMenu:addParam("jungleclearW", "Use E in Jungle Clear", SCRIPT_PARAM_ONOFF, true)

	Config:addSubMenu("Harass", "harassMenu")
		Config.harassMenu:addParam("harassW", "Use W in Harass", SCRIPT_PARAM_ONOFF, true)
		Config.harassMenu:addParam("harassE", "Use E in Harass", SCRIPT_PARAM_ONOFF, true)
		Config.harassMenu:addParam("rIsActive", "Ult Test", SCRIPT_PARAM_ONOFF, false)

	Config:addSubMenu("Keys", "keys")
		Config.keys:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		Config.keys:addParam("laneclear", "Lane/Jungle Clear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		Config.keys:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		Config.keys:addParam("lasthit", "Last Hit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))


	Config:addSubMenu("Misc Settings", "items")
		Config.items:addParam("items", "Enable Item Usage", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("ignite", "Enable Ignite Usage", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("smite", "Enable Smite Usage", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("space", "", SCRIPT_PARAM_INFO, "")
		Config.items:addParam("zhonyas", "Enable Auto Zhonyas", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("zhonyasLife", "Casts Zhonyas at %", SCRIPT_PARAM_SLICE, 20, 0, 100, 1)
		Config.items:addParam("space", "", SCRIPT_PARAM_INFO, "")
		Config.items:addParam("healpot", "Enable Health Pot Usage", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("healpotLife", "Uses Pot at %", SCRIPT_PARAM_SLICE, 50, 0, 100, 1)
		Config.items:addParam("space", "", SCRIPT_PARAM_INFO, "")
		Config.items:addParam("safetyW", "Use W on Low Life", SCRIPT_PARAM_ONOFF, true)
		Config.items:addParam("safetyWLife", "Heal with W at %", SCRIPT_PARAM_SLICE, 20, 0, 100, 1)

	Config:addSubMenu("Draws", "draws")
		Config.draws:addParam("drawAll", "Disable all draws", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawW", "Draw W Range", SCRIPT_PARAM_ONOFF, true)
		Config.draws:addParam("drawE", "Draw E Range", SCRIPT_PARAM_ONOFF, true)

		TargetSelector 				= TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000)
		enemyMinions 				= minionManager(MINION_ENEMY, 450, myHero, MINION_SORT_MAXHEALTH_DEC)
		jungleMinions				= minionManager(MINION_JUNGLE, 450, myHero, MINION_SORT_HEALTH_ASC)

		Config:addTS(TargetSelector)
		SxOrb:LoadToMenu()


		Config:permaShow("author")
		Config:permaShow("space")
		Config.keys:permaShow("combo")
		Config.comboMenu:permaShow("ferocityUsage")
		Config.keys:permaShow("laneclear")
		Config.laneclearMenu:permaShow("wToHealLaneClear")
		Config.jungleclearMenu:permaShow("ferocityUsageJungle")
		Config.keys:permaShow("harass")
		Config.keys:permaShow("lasthit")


		SummonerSpellFind()

	else
		print("Your champion is not supported right now!")
		supportedChamp = false
	end		
end

function OnTick()
	if supportedChamp == true then

		TargetSelector:update()
		enemyMinions:update()
		jungleMinions:update()

		IgniteDamage				= 50 + (20 * myHero.level)
		target 						= TargetSelector.target
		QReady 						= myHero:CanUseSpell(_Q)
		WReady 						= myHero:CanUseSpell(_W)
		EReady 						= myHero:CanUseSpell(_E)
		RReady 						= myHero:CanUseSpell(_R)
		smiteMinionDamage 			= math.max(20*myHero.level+370,30*myHero.level+330,40*myHero.level+240,50*myHero.level+100)
		smiteChampionDamage 		= (20+8*myHero.level)
		ferocity 					= myHero.mana
		range 						= myHero.range + GetDistance(myHero.maxBBox)

		OnCombo()
		OnHarass()
		OnLaneClear()
		OnJungleClear()
		SummonerSpellUsage()
		Items()
	end
end

function OnCombo()

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end

		if Config.keys.combo then
			if ValidTarget(target) and tdis < range and ferocity == 5 and Config.comboMenu.ferocityUsage == 1 then
				CastSpell(_Q)
			else if ValidTarget(target) and ferocity == 5 and Config.comboMenu.ferocityUsage == 2 then
				CastSpell(_W)
			else if ValidTarget(target) and tdis < ERange and ferocity == 5 and Config.comboMenu.ferocityUsage == 3 then
				local ECastPos, EHitChance = HP:GetPredict(HP_E, target, myHero)
				if EHitChance >= 2 then
					CastSpell(_E, ECastPos.x, ECastPos.z)
				end
				else
					if ValidTarget(target) and tdis < range then
						CastSpell(_Q)
						if ValidTarget(target) and tdis < WRange then
							CastSpell(_W)
							local ECastPos, EHitChance = HP:GetPredict(HP_E, target, myHero)
							if EHitChance >= 2 then
								CastSpell(_E, ECastPos.x, ECastPos.z)
							end
						end
					else
						if ValidTarget(target) and tdis > range and rIsActive == false then
							local ECastPos, EHitChance = HP:GetPredict(HP_E, target, myHero)
							if EHitChance >= 2 then
								CastSpell(_E, ECastPos.x, ECastPos.z)
							end
						end
					end
				end
			end
		end
	end
end


function OnHarass()

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end
	
	if Config.keys.harass and Config.harassMenu.harassW and ValidTarget(target) and WReady and tdis < WRange then
		CastSpell(_W)
	end

	if ValidTarget(target) and Config.keys.harass and tdis > range then
		local ECastPos, EHitChance = HP:GetPredict(HP_E, target, myHero)
		if EHitChance >= 2 then
			CastSpell(_E, ECastPos.x, ECastPos.z)
		end
	end
end


function OnLaneClear()

		for i, minion in pairs(enemyMinions.objects) do

			if ValidTarget(minion) then
				mdis = GetDistance(minion)
			end

			if Config.laneclearMenu.wToHealLaneClear and Config.keys.laneclear and ferocity == 5 then
				CastSpell(_W)
			end


			if minion ~= nil and ValidTarget(minion) and Config.keys.laneclear then
				if Config.laneclearMenu.LaneclearE then
	  		    	local ECastPos, EHitChance = HP:GetPredict(HP_E, minion, myHero)
					if EHitChance >= 2 then
						CastSpell(_E, ECastPos.x, ECastPos.z)
					end
				if Config.laneclearMenu.laneclearQ then
					CastSpell(_Q)
				if Config.laneclearMenu.laneclearW then
					CastSpell(_W)
					end
				end
			end
		end
  	end
end


function OnJungleClear()
		
					for j, minion in pairs(jungleMinions.objects) do

						if ValidTarget(minion) then
							mdis = GetDistance(minion)
						end

						if Config.keys.laneclear and Config.jungleclearMenu.ferocityUsageJungle == 1 then
							CastSpell(_Q)
						end
						if Config.keys.laneclear and Config.jungleclearMenu.ferocityUsageJungle == 2 then
							CastSpell(_W)
						end
						if Config.keys.laneclear and Config.jungleclearMenu.ferocityUsageJungle == 3 then
							local ECastPos, EHitChance = HP:GetPredict(HP_E, minion, myHero)
							if EHitChance >= 2 then
								CastSpell(_E, ECastPos.x, ECastPos.z)
							end
						end
						if minion ~= nil and ValidTarget(minion) and Config.keys.laneclear then
							if Config.jungleclearMenu.jungleclearE then
				  		    	local ECastPos, EHitChance = HP:GetPredict(HP_E, minion, myHero)
								if EHitChance >= 2 then
									CastSpell(_E, ECastPos.x, ECastPos.z)
								end
							if Config.jungleclearMenu.jungleclearQ then
								CastSpell(_Q)
							if Config.jungleclearMenu.jungleclearW then
								CastSpell(_W)
								end
							end
						end
					end
			  	end
			end





function Items()

	myHeroHpPots = myHero.maxHealth / 100 * Config.items.healpotLife
	myHeroPercent = myHero.maxHealth / 100 * Config.items.zhonyasLife
	myHeroWPercent = myHero.maxHealth / 100 * Config.items.safetyWLife

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end
	

	if myHero.health < myHeroHpPots and Config.items.healpot and potDelayFunction == true then 
		local Slot = GetInventorySlotItem(2003)
    	if Slot ~= nil and myHero:CanUseSpell(Slot) then
    	   	CastSpell(Slot)
    	end
	end
		if myHero.health < myHeroWPercent and Config.items.safetyW and ferocity == 5 and WReady and Recall == false then 
		CastSpell(_W)
	end

	    if myHero.health < myHeroPercent and Config.items.zhonyas then
    	local Slot = GetInventorySlotItem(3157)
    	if Slot ~= nil and myHero:CanUseSpell(Slot) and tdis < tiamatRange then
    	   	CastSpell(Slot)
    	end
	end 	

		if Config.keys.combo and Config.items.items and ValidTarget(target) then
			local Slot = GetInventorySlotItem(3077) or GetInventorySlotItem(3074)
	    	if Slot ~= nil and myHero:CanUseSpell(Slot) and tdis < tiamatRange then
	    	   	CastSpell(Slot)
	    	end
	    end

		if Config.keys.laneclear and Config.items.items and mdis ~= nil then
			local Slot = GetInventorySlotItem(3077) or GetInventorySlotItem(3074)
	    	if Slot ~= nil and myHero:CanUseSpell(Slot) and mdis < tiamatRange and Config.laneclearMenu.items then
	    		CastSpell(Slot)
	    		mdis = nil
	    	else if Slot ~= nil and myHero:CanUseSpell(Slot) and mdis < tiamatRange and Config.jungleclearMenu.items then
	    		CastSpell(Slot)
	    		mdis = nil
	    	end
		end
	end

		if Config.keys.combo and Config.items.items and ValidTarget(target) then
		local Slot = GetInventorySlotItem(3142)
    	if Slot ~= nil and myHero:CanUseSpell(Slot) and tdis < tiamatRange then
    	   	CastSpell(Slot)
    	end
	end

		if Config.keys.combo and Config.items.items and ValidTarget(target) then
		local Slot = GetInventorySlotItem(3153)
    	if Slot ~= nil and myHero:CanUseSpell(Slot) and tdis < tiamatRange then
    	   	CastSpell(Slot, target)
    	end
	end

		if Config.keys.combo and Config.items.items and ValidTarget(target) then
		local Slot = GetInventorySlotItem(3144)
    	if Slot ~= nil and myHero:CanUseSpell(Slot) and tdis < tiamatRange then
    	   	CastSpell(Slot, target)
    	end
	end
end


function SummonerSpellUsage()

	if ignite ~= nil then
		IgniteReady	= myHero:CanUseSpell(ignite)
	end

	if smite ~= nil then
		SmiteReady	= myHero:CanUseSpell(smite)
	end

	if ValidTarget(target) then 
		tdis  = GetDistance(target)
	end

	if ignite ~= nil and Config.items.ignite and ValidTarget(target) then
		if IgniteReady and target.health < IgniteDamage and tdis < igniteRange then
			CastSpell(ignite, target)
		end
	end

	if smite ~= nil and Config.items.smite and ValidTarget(target) and Config.keys.combo then
		if SmiteReady and tdis < smiteRange then
			CastSpell(smite, target)
		end
	end
end
		

function OnDraw()
	if supportedChamp == true then
		if Config.draws.drawAll and Config.draws.drawW then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, WRange , 1, ARGB(255,255,255,255))
		end

		if Config.draws.drawAll and Config.draws.drawE then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, ERange , 1, ARGB(255,255,255,255))
		end
	end
end


function OnApplyBuff(source, unit, buff)
	if unit and unit.isMe and buff.name == "RegenerationPotion" then
		potDelayFunction = false
	end
	if unit and unit.isMe and buff.name == "recall" then
		Recall = true
	end
	if unit and unit.isMe and buff.name == "RengarR" then
    	rIsActive = true
  	end
end

function OnRemoveBuff(unit, buff)
    if unit and unit.isMe and buff.name == "RegenerationPotion" then
        potDelayFunction = true
    end
    if unit and unit.isMe and buff.name == "recall" then
		Recall = false
	end
	if unit and unit.isMe and buff.name == "RengarR" then
    	rIsActive = false
  	end
end


function SummonerSpellFind()
		if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
			ignite = SUMMONER_1 
		else if myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
			ignite = SUMMONER_2 
		else 
			ignite = nil
		end

		if myHero:GetSpellData(SUMMONER_1).name:find("summonersmite") then
			smite = SUMMONER_1 
		elseif myHero:GetSpellData(SUMMONER_2).name:find("summonersmite") then 
			smite = SUMMONER_2
		else
			smite = nil
		 end
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
