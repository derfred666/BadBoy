if select(3,UnitClass("player")) == 2 then
	if not initDone then
		_ArcaneTorrent				= 	155145
		_ArdentDefender             =   31850
		_AvengersShield             =   31935
		_AvengingWrath              =   31884
		_BastionOfGlory				=	114637
		_BeaconOfLight              =   53563
		_BeaconOfFaith				= 	156910
		_Berserking                 =   26297
		_BlazingContemp 			= 	166831
		_BlessingOfKings            =   20217
		_BlessingOfMight            =   19740
		_BlindingLight              =   115750
		_BloodFury                  =   20572
		_Cleanse                    =   4987
		_Consecration               =   26573
		_CrusaderStrike             =   35395
		_Denounce                   =   2812
		_DevotionAura               =   31821
		_DivineCrusader 			= 	144595
		_DivineFavor                =   31842
		_DivineLight                =   82326
		_DivineProtection           =   498
		_DivinePurpose 				= 	86172
		_DivinePurposeBuff			= 	90174
		_DivineShield               =   642
		_DivineStorm                =   53385
		_EternalFlame               =   114163
		_ExecutionSentence          =   114157
		_Exorcism                   =   879
		_FinalVerdict 				= 	157048
		_FistOfJustice              =   105593
		_FlashOfLight               =   19750
		_Forbearance				= 	25771
		_HandOfFreedom              =   1044
		_HandOfProtection           =   1022
		_HandOfPurity               =   114039
		_HandOfSacrifice            =   6940
		_HandOfSalvation            =   1038
		_HammerOfJustice            =   853
		_HammerOfTheRighteous       =   53595
		_HammerOfWrath              =   24275
		_HolyAvenger                =   105809
		_HolyLight                  =   82326
		_HolyPrism                  =   114165
		_HolyRadiance               =   82327
		_HolyShock                  =   20473
		_HolyWrath                  =   119072
		_GiftOfTheNaaru             =   59542
		_GuardianOfAncientKings     =   86659
		_GuardianOfAncientKingsHoly =   86669
		_GuardianOfAncientKingsRet  =   86698
		_Inquisition                =   84963
		_Judgment      	            =   20271
		_LayOnHands                 =   633
		_LightOfDawn                =   85222
		_LightsHammer               =   114158
		_MassExorcism               =   122032
		_MassResurection            =   83968
		_Rebuke                     =   96231
		_Reckoning                  =   62124
		_Redemption                 =   7328
		_RighteousFury              =   25780
		_Repentance                 =   20066
		_SanctifiedWrath            =   53376
		_SacredShield               =   20925
		_SealOfInsight              =   20165
		_SealOfRighteousness        =   20154
		_SealOfThruth               =   31801
		_SelflessHealer             =   85804
		_SelflessHealerBuff			= 	114250
		_Seraphim					=	152262
		_ShieldOfTheRighteous       =   53600
		_SpeedOfLight               =   85499
		_TemplarsVerdict            =   85256
		_TurnEvil                   =   10326
		_WordOfGlory                =   85673

		HandOfSacrifaceDebuffs = { -- Table that holds debuffs we should HoSacrifice
			{ debuff = 166675, stacks = 2 }, -- Shrapnel Blast  in Grimrail depot
		}
		protectionRemovableDebuffs = {} -- Table that holds debuffs that we should remove with protection spell
		snareToBeRemovedByHandsofFreedom = {
			162066,  -- Freezing Snare, Grim Depot
		}
		initDone = true
	end
	
	function checkForDebuffThatIShouldRemovewithHoF(unit)
		for i = 1, #snareToBeRemovedByHandsofFreedom do
			if UnitDebuffID(unit, snareToBeRemovedByHandsofFreedom[i]) then
				return true
			end
		end
		return false
	end
	
	function castHandOfFreedom(unit)
		if canCast(_HandOfFreedom) then
			if castSpell(unit,_HandOfFreedom,true) then 
				return true
			end
		end
		return false
	end
	-- Todo : Check Glyphs(is on us or can we cast it on ground 25 yards
	function castArcaneTorrent()
		if canCast(_ArcaneTorrent) then
			if castSpell("player",_ArcaneTorrent,true) then 
				return true
			end
		end
		return false
	end

	-- Todo : Check Glyphs(is on us or can we cast it on ground 25 yards
	function castConsecration(unit)
		if canCast(_Consecration) and isInMelee(unit) then
			if castSpell("player",_Consecration,true) then 
				return true
			end
		end
		return false
	end

	-- Todo : Execution sentence make sure we cast on a unit with as much HP as possible
	function castExecutionSentence(unit)
		if isSelected("Execution Sentence") and canCast(_ExecutionSentence) then
			if (isDummy(dynamicUnit.dyn40) or (UnitHealth(dynamicUnit.dyn40) >= 400*UnitHealthMax("player")/100)) then
				if castSpell(dynamicUnit.dyn40,_ExecutionSentence,false,false) then 
					return true
				end
			end
		end
		return false
	end



	--Todo, we can check if the target is not inmelle there could be other targets in melee
	function castHolyWrath(unit)
		if canCast(_HolyWrath) and isInMelee(unit) then
			if castSpell(unit,_HolyWrath,true,false) then
				return true
			end
		end
		return false
	end

	function castLightsHammer(unit)
		if isChecked("Light's Hammer") then
			if getGround(unit) and not isMoving(unit) and UnitExists(unit) and ((isDummy(unit) or getDistance(unit,"targettarget") <= 5)) then
				if castGround(unit,_LightsHammer,30) then
					return true
				end
			end
		end
		return false
	end

	function castAvengersShield(unit)
		if canCast(_AvengersShield) then
			if getLineOfSight("player",unit) and getDistance("player",unit) <= 30 then
				if castSpell(unit,_AvengersShield,false,false) then
					return true
				end
			end
		end
		return false
	end

	function castJudgement(unit)
		if canCast(_Judgment) and getDistance("player", unit) <= 30 then
			if castSpell(unit,_Judgment,true,false) then
				return true
			end
		end
		return false
	end

	function castHammerOfWrath(unit)
		if canCast(_HammerOfWrath) and getLineOfSight("player",unit) and getDistance("player",unit) <= 30 and getHP(unit) <= 20 then
			if castSpell(unit,_HammerOfWrath,false,false) then
				return true
			end
		end
		return false
	end

	--ToDo :Sacred Shield is affected but Resolve. So we should snapshot resolve and if we are getting X procent more then we should reapply. 340% is max of resolve buff
	function castSacredShield(timeleft) -- Parameter is time left on buff
		local timeleft = timeleft or 0
		if not isBuffed("player", _SacredShield, timeleft) then
			if castSpell("player",_SacredShield,false,false) then
				return true
			end
		end
		return false
	end
	--function SacredShield()
    --       local SacredShieldCheck = BadBoy_data["Check Sacred Shield"];
    --  -      local SacredShield = BadBoy_data["Box Sacred Shield"];
    --        if UnitBuffID("player",20925) then SacredShieldTimer = select(7, UnitBuffID("player",20925)) - GetTime() else SacredShieldTimer = 0 end
    --       if SacredShieldCheck and getHP("player") <= SacredShield then
    --            if ((isMoving("player") or UnitAffectingCombat("player")) and not UnitBuffID("player",20925)) or (LastVengeance ~= nil and (GetVengeance() > (BadBoy_data["Box Sacred Vengeance"] + LastVengeance))) then
    --                LastVengeance = GetVengeance()
    --               return true;
    --            end
    --            if SacredShieldTimer <= 3 then
    --                return true;
    --            end
    --        end
    --        return false;
    --    end
	-- Todo: We should calculate expected heal with resolve to not overheal
	function castWordOfGlory(unit, health, holypower)
		if health == 0 then --Set it to 0 if we should use config set value
			health = getValue("Word Of Glory On Self")
		end

		if getHP(unit) <= health and (holypower > holypower or UnitBuffID("player", _DivinePurposeBuff)) then -- Handle this via config? getHP does it include incoming heals? Bastion of Glory checks?
			if castSpell(unit,_WordOfGlory,true,false) then
				return true
			end
		end
		return false
	end

	function castShieldOfTheRighteous(unit, holypower)
		if canCast(_ShieldOfTheRighteous) and (holypower >= holypower or UnitBuffID("player", _DivinePurposeBuff)) then
			if getDistance("player",unit) <= 4 then
				if castSpell(unit,_ShieldOfTheRighteous,false,false) then
					return true
				end
			end
			--Todo, we could check other targets to use HP on but this should be controlled by config.
		end
		return false
	end

	function castHandOfSacrifice()
	-- Todo: We should add glyph check or health check, at the moment we assume the glyph
	-- Todo:  We should be able to config who to use as candidate, other tank, healer, based on debuffs etc.
	-- Todo: add check if target already have sacrifice buff
	-- Todo Is the talent handle correctly? 2 charges? CD starts but u have 2 charges
	-- This is returning false since its not proper designed yet. We need to have a list of scenarios when we should cast sacrifice, off tanking, dangerous debuffs/dots or high spike damage on someone.
		return false
	end

	-- Todo This need to be enhanced to be much more logical
	function castLayOnHands(unit)
		if castSpell(unit,_LayOnHands,true,false) then
			return true
		end
		return false
	end

	-- Todo we are only checking lowest healthm we need to switch to threat
	-- Todo Add buff cehck if target already have the buff
	-- Todo Is the talent handle correctly? 2 charges? CD starts but u have 2 charges
	function castHandOfSalvation(unit)
		-- This is not coded properly yet, we need a threat list to see how has threat, then we need to make sure to handle tank switching etc.
		return false
	end

	function castRebuke(unit)
		castInterrupt(_Rebuke, getValue("Rebuke"))
		return false
	end

	function castHammerOfJustice(unit)
		-- We check if we have the talent
		return false
	end

	function castRighteousFury()
		if isChecked("Righteous Fury") then
			if UnitBuffID("player",_RighteousFury)== nil then
				if castSpell("player",_RighteousFury, true, false) then
					return true
				end
			end
		end
		return false
	end
		-- Holy Avenger(Ret)
	function castHolyAvenger(holypower)
		if isSelected("Holy Avenger") and canCast(_HolyAvenger) then
			if (isDummy(dynamicUnit.dyn5) or (UnitHealth(dynamicUnit.dyn5) >= 400*UnitHealthMax("player")/100)) then
				-- holy_avenger,sync=seraphim,if=talent.seraphim.enabled
				if (isKnown(_Seraphim) and UnitBuffID("player",_Seraphim))
				  -- holy_avenger,if=holy_power<=2&!talent.seraphim.enabled
				  or (not isKnown(_Seraphim) and holypower <= 2) then
					if castSpell("player",_HolyAvenger,true,false) then 
						return true
					end
				end
			end
		end
		return false
	end

	-- Avenging Wrath
	function castAvengingWrath()
		if isSelected("Holy Avenger") and canCast(_HolyAvenger) then
			if (isDummy(dynamicUnit.dyn5) or (UnitHealth(dynamicUnit.dyn5) >= 400*UnitHealthMax("player")/100)) then
				-- avenging_wrath,sync=seraphim,if=talent.seraphim.enabled
				if (isKnown(_Seraphim) and UnitBuffID("player",_Seraphim) )
				  -- avenging_wrath,if=!talent.seraphim.enabled
				  or not isKnown(_Seraphim) then
					if castSpell("player",_HolyAvenger,true,false) then 
						return true
					end
				end
			end
		end
		return false
	end

	-- Seraphim
	function castSeraphim()
		if isSelected("Seraphim") and canCast(_Seraphim) then
			if (isDummy(dynamicUnit.dyn5) or (UnitHealth(dynamicUnit.dyn5) >= 400*UnitHealthMax("player")/100)) then
				if castSpell("player",_Seraphim,true,false) then 
					return true
				end
			end
		end
		return false
	end

	-- DivineProtection(Ret)
	function castDivineProtection()
		if isChecked("Divine Protection") and getHP("player") <= getValue("Divine Protection") then
			if castSpell("player",_DivineProtection,true) then
				return
			end
		end
	end

	-- exorcist support both glyphed and not glyphed
	function castExorcism()
		if hasGlyph(122028) then
			if castSpell(dynamicUnit.dyn5,_MassExorcism,false,false) then
				return
			end
		else
			if castSpell(dynamicUnit.dyn30,_Exorcism,false,false) then
				return
			end
		end
	end

	function castDivineStorm()
		if castSpell(dynamicUnit.dyn5,_DivineStorm,false,false) then
	  		return
	  	end
	end

	function castTemplarsVerdict()
		if castSpell(dynamicUnit.dyn5,_TemplarsVerdict,false,false) then 
			return
		end
	end

	function castMultiHammerOfWrath()
		for i = 1, #enemiesTable do
			-- define thisUnit
			local thisUnit = enemiesTable[i]
			-- if
			if (thisUnit.hp and (thisUnit.hp <= 20) or getBuffRemain("player",_AvengingWrath) > 0) and getFacing("player",thisUnit.unit) == true then
				if castSpell(thisUnit.unit,_HammerOfWrath,false,false) then 
					return
				end
			end
		end
	end

	function castHolyPrism(unit,facing)
		if castSpell(unit,_HolyPrism,facing,false) then 
			return
		end
	end

	function castCrusaderStrike()
		if castSpell(dynamicUnit.dyn5,_CrusaderStrike,false,false) then 
			return
		end		
	end

	function castHammerOfTheRighteous()
		if castSpell(dynamicUnit.dyn5,_HammerOfTheRighteous,false,false) then
			return
		end
	end

	function castSealOfTruth()
		CastShapeshiftForm(1)
		return true
	end

	function castSealOfRigtheousness()
		CastShapeshiftForm(2)
		return true
	end
end