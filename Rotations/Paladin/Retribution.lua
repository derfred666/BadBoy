if select(3, UnitClass("player")) == 2 then
	function PaladinRetribution()
	if currentConfig ~= "Retribution Paladin" then --Where is currentConfig set? Is this only used for init?
		--PaladinRetFunctions(); --Prot functions is SacredShield and GetHolyGen
		PaladinRetToggles() -- Setting up Toggles, AoE, Interrupt, Defensive CD, CD, Healing
		PaladinRetOptions() -- Reading Config values from gui?
		currentConfig = "Retribution Paladin"
	end
	dynamicUnit = {
		["dyn5"] = dynamicTarget(5,true),
		["dyn30"] = dynamicTarget(30,true),
		["dyn30AoE"] = dynamicTarget(30,false),
		["dyn40"] = dynamicTarget(40,true)
	}
	-- Locals Variables
	local _HolyPower = UnitPower("player", 9)
	local meleeEnemies = #getEnemies("player", 5) --Get number of enemies within melee range. Does this also work for large hotboxes?
	local buffDivineCrusader = getBuffRemain("player",_DivineCrusader) 
	local buffHolyAvenger = getBuffRemain("player",_HolyAvenger)
	local buffDivinePurpose = getBuffRemain("player",_DivinePurpose)
	local buffFinalVerdict = getBuffRemain("player",_FinalVerdict)
	local buffSeraPhim = getBuffRemain("player",_Seraphim)
	local buffBlazingContemp = getBuffRemain("player",_BlazingContemp)
	local buffAvengingWrath = getBuffRemain("player",_AvengingWrath)
	local buffLiadrinsRighteousness = getBuffRemain("player",156989) 
	local buffMaraadsTruth = getBuffRemain("player",156990) 
	local sealOfTruth = GetShapeshiftForm() == 1 or nil
	local sealOfRighteousness = GetShapeshiftForm() == 2 or nil

	-- Food/Invis Check   Hm here we are checking if we should abort the rotation pulse due to if we are a vehicle or some stuff
	-- canRun is already checking UnitInVehicle and some other stuff im not sure about.
	if canRun() ~= true then
		return false
	end
	-- off-GCD
	-- rebuke
	if UnitAffectingCombat("player") then
		-- Rebuke
		castRebuke(unit)

		-- Divine Protection
		castDivineProtection()
	end

	-- Combats Starts Here
	if isInCombat("player") then
		-- Lay on Hands
		if getHP("player") <= getValue("Lay On Hands") then
			if castSpell("player",_LayOnHands,true) then
				return
			end
		else
			for i = 1, #nNova do
				if nNova[i].hp <= getValue("Lay On Hands") then
					if castSpell(nNova[i].unit,_LayOnHands,true) then
						return
					end
				end
			end
		end

		-- Selfless Healer
		if getHP("player") <= getValue("Selfless Healer") then
			if castSpell("player",_FlashOfLight,true) then
				return
			end
		else
			for i = 1, #nNova do
				if nNova[i].hp <= getValue("Selfless Healer") then
					if castSpell(nNova[i].unit,_FlashOfLight,true) then
						return
					end
				end
			end
		end

		-- potion,name=draenic_strength,if=(buff.bloodlust.react|buff.avenging_wrath.up|target.time_to_die<=40)
		--[[Always]]
		-- auto_attack
		if isInMelee() and getFacing("player", myTarget) == true then
			RunMacroText("/startattack")
		end

		castCrowdControl("any",105593,20) -- 853
		-- speed_of_light,if=movement.distance>5

		-- GCD check
		if castingUnit() then return end

		-- execution_sentence
		castExecutionSentence(dynamicUnit.dyn40)

		-- lights_hammer
		castLightsHammer(dynamicUnit.dyn30AoE)

		-- Holy Avenger
		castHolyAvenger(_HolyPower)

		-- Avenging Wrath
		castAvengingWrath()

		-- use_item,name=vial_of_convulsive_shadows,if=buff.avenging_wrath.up
		-- blood_fury
		-- berserking
		-- arcane_torrent
		-- seraphim
		castSeraphim(_HolyPower)
		--[[Single(1-2)]]
		if meleeEnemies < 3 then
			-- divine_storm,if=buff.divine_crusader.react&holy_power=5&buff.final_verdict.up
			if (buffDivineCrusader > 0 and _HolyPower == 5 and buffFinalVerdict > 0)
			  -- divine_storm,if=buff.divine_crusader.react&holy_power=5&active_enemies=2&!talent.final_verdict.enabled
			  or (buffDivineCrusader > 0 and _HolyPower == 5 and meleeEnemies == 2)
			  -- divine_storm,if=holy_power=5&active_enemies=2&buff.final_verdict.up
			  or (_HolyPower == 5 and meleeEnemies == 2 and buffFinalVerdict > 0)
			  -- divine_storm,if=buff.divine_crusader.react&holy_power=5&(talent.seraphim.enabled&cooldown.seraphim.remains<=4)
			  or (_HolyPower == 5 and meleeEnemies == 2 and isKnown(_Seraphim) and getSpellCD(_Seraphim) <= 4) then
			  	castDivineStorm()
			end
			-- templars_verdict,if=holy_power=5|buff.holy_avenger.up&holy_power>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
			if _HolyPower == 5 
			  or ((buffHolyAvenger and _HolyPower >= 3) and (not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4))
			  -- templars_verdict,if=buff.divine_purpose.react&buff.divine_purpose.remains<4
			  or (buffDivinePurpose > 0 and buffDivinePurpose < 4) then
			  	castTemplarsVerdict()
			end
			-- divine_storm,if=buff.divine_crusader.react&buff.divine_crusader.remains<4&!talent.final_verdict.enabled
			if buffDivineCrusader and buffDivineCrusader < 4 and not isKnown(_FinalVerdict) then
			  	castDivineStorm()
			end		
			if isKnown(_FinalVerdict)
			  -- final_verdict,if=holy_power=5|buff.holy_avenger.up&holy_power>=3
			 and (_HolyPower == 5 or (buffHolyAvenger > 1 and _HolyPower >= 3)
			  -- final_verdict,if=buff.divine_purpose.react&buff.divine_purpose.remains<4
			  or (buffDivinePurpose > 0 and buffDivinePurpose < 4)) then
			  	castTemplarsVerdict()
			end	  	
			-- hammer_of_wrath
			castMultiHammerOfWrath()
			-- judgment,if=talent.empowered_seals.enabled&((seal.truth&buff.maraads_truth.remains<cooldown.judgment.duration*2)
			if isKnown(152263) then
				if buffLiadrinsRighteousness < 8 then
					if (sealOfTruth and buffMaraadsTruth < getSpellCD(_Judgment) + 5)
					  -- |(seal.righteousness&buff.liadrins_righteousness.remains<cooldown.judgment.duration*2))
					  or (sealOfRighteousness and buffLiadrinsRighteousness < getSpellCD(_Judgment) + 5) then
					  	castJudgement(dynamicUnit.dyn5)
					end
				end
			end
			-- exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
			if UnitBuffID("player",_BlazingContemp) and HolyPower <= 2 then
				castExorcism(dynamicUnit.dyn30)
			end
			-- seal_of_truth,if=talent.empowered_seals.enabled&buff.maraads_truth.remains<(cooldown.judgment.duration)&buff.maraads_truth.remains<=3
			if isKnown(152263) then
				if buffMaraadsTruth < getSpellCD(_Judgment) and buffMaraadsTruth <= 3 then
					castSealOfTruth()
				end
			end
			-- divine_storm,if=buff.divine_crusader.react&buff.final_verdict.up&(buff.avenging_wrath.up|target.health.pct<35)
			if _DivineCrusader > 0 and buffFinalVerdict > 0 and (buffAvengingWrath or getHP(dynamicUnit.dyn5) < 35) then
				castDivineStorm()
			end
			-- final_verdict,if=buff.divine_purpose.react|target.health.pct<35
			if buffDivinePurpose > 0 or getHP(dynamicUnit.dyn5) < 35 then
				castTemplarsVerdict()
			end
			-- templars_verdict,if=buff.avenging_wrath.up|target.health.pct<35&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
			if buffAvengingWrath > 0 or getHP(dynamicUnit.dyn5) < 35 and (not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4) then
				castTemplarsVerdict()
			end
			-- crusader_strike
			castCrusaderStrike(dynamicUnit.dyn5)
			-- divine_storm,if=buff.divine_crusader.react&(buff.avenging_wrath.up|target.health.pct<35)&!talent.final_verdict.enabled
			if buffDivineCrusader > 0 and (buffAvengingWrath > 0 or getHP(dynamicUnit.dyn5) < 35) and not isKnown(_FinalVerdict) then
				castDivineStorm()
			end
			-- divine_storm,if=buff.divine_crusader.react&buff.final_verdict.up
			if buffDivineCrusader > 0 and buffFinalVerdict > 0 then
				castDivineStorm()
			end
			-- final_verdict
			if isKnown(_FinalVerdict) then
				castTemplarsVerdict()
			end
			-- seal_of_righteousness,if=talent.empowered_seals.enabled&buff.liadrins_righteousness.remains<(cooldown.judgment.duration)&buff.liadrins_righteousness.remains<=3
			if isKnown(152263) then
				if buffLiadrinsRighteousness < getSpellCD(_Judgment) and buffLiadrinsRighteousness <= 3 then
					castSealOfRigtheousness()
				end
			end
			-- judgment
			castJudgement(dynamicUnit.dyn5)
			-- templars_verdict,if=buff.divine_purpose.react
			if _DivinePurpose > 0 then
				castTemplarsVerdict()
			end
			-- divine_storm,if=buff.divine_crusader.react&!talent.final_verdict.enabled
			if buffDivineCrusader and not isKnown(_FinalVerdict) then
			  	castDivineStorm()
			end		
			-- templars_verdict,if=holy_power>=4&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
			if _HolyPower >= 4 and (not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4) then
				castTemplarsVerdict()
			end		
			-- exorcism
			castExorcism()
			-- templars_verdict,if=holy_power>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
			if _HolyPower >= 3 and (not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4) then
				castTemplarsVerdict()
			end	
			-- holy_prism
			castHolyPrism(dynamicUnit.dyn40,false)
		elseif meleeEnemies < 5 then
			--[[Cleave(3-4)]]
			-- final_verdict,if=buff.final_verdict.down&holy_power=5
			if buffFinalVerdict > 0 or _HolyPower == 5 then
				castTemplarsVerdict()
			end
			-- divine_storm,if=holy_power=5&buff.final_verdict.up
			if _HolyPower == 5 and buffFinalVerdict > 0 then
				castDivineStorm()
			end
			-- divine_storm,if=holy_power=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled
			if _HolyPower == 5 and (not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4) and not isKnown(_FinalVerdict) then
				castDivineStorm()
			end
			-- exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
			if buffBlazingContemp > 0 and _HolyPower <= 2 and not buffHolyAvenger then
				castExorcism()
			end
			-- hammer_of_wrath
			castMultiHammerOfWrath()
			-- judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
			if isKnown(152263) then
				if sealOfRighteousness and buffLiadrinsRighteousness <= 5 then
					castJudgement()
				end
			end
			-- divine_storm,if=(!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled
			if (not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4) and not isKnown(_FinalVerdict) then
				castDivineStorm()
			end
			-- crusader_strike
			castCrusaderStrike(dynamicUnit.dyn5)
			-- final_verdict,if=buff.final_verdict.down
			if buffFinalVerdict == 0 then
				castTemplarsVerdict()
			else
			-- divine_storm,if=buff.final_verdict.up
				castDivineStorm()
			end
			-- judgment
			castJudgement(dynamicUnit.dyn30AoE)
			-- exorcism
			castExorcism()
			-- holy_prism
			castHolyPrism("player",true)
		else
			--[[AoE(5+)]]
			-- divine_storm,if=holy_power=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
			if _HolyPower == 5 and (not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4) then
				castDivineStorm()
			end
			-- exorcism,if=buff.blazing_contempt.up&holy_power<=2&buff.holy_avenger.down
			if buffBlazingContemp > 0 and _HolyPower <= 2 and buffHolyAvenger == 0 then
				castExorcism()
			end
			-- hammer_of_the_righteous
			castHammerOfTheRighteous(dynamicUnit.dyn5)
			-- judgment,if=talent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5
			if isKnown(152263) then
				if sealOfRighteousness and buffLiadrinsRighteousness <= 5 then
					castJudgement()
				end
			end
			-- hammer_of_wrath
			castMultiHammerOfWrath()
			-- divine_storm,if=(!talent.seraphim.enabled|cooldown.seraphim.remains>4)
			if not isKnown(_Seraphim) or getSpellCD(_Seraphim) > 4 then
				castDivineStorm()
			end
			-- exorcism,if=glyph.mass_exorcism.enabled
			if hasGlyph(122028) then
				castExorcism()
			end
			-- judgment
			castJudgement(dynamicUnit.dyn5)
			-- exorcism
			castExorcism()
			-- holy_prism
			castHolyPrism("player",true)
		end
	end
end
end