if select(3,UnitClass("player")) == 10 then

--[[           ]]   --[[           ]]   --[[           ]]   --[[]]     --[[]]
--[[           ]]   --[[           ]]   --[[           ]]   --[[]]     --[[]]
--[[]]     --[[]]   --[[]]     --[[]]   --[[]]              --[[ ]]   --[[ ]]
--[[         ]]     --[[           ]]   --[[           ]]   --[[           ]]
--[[]]     --[[]]   --[[        ]]      --[[]]              --[[           ]]
--[[           ]]   --[[]]    --[[]]    --[[           ]]   --[[ ]]   --[[ ]]
--[[           ]]   --[[]]     --[[]]   --[[           ]]    --[[]]   --[[]]

   function MonkBrewToggles()

        -- Aoe Button
        if AoEModesLoaded ~= "Brew Monk AoE Modes" then
            AoEModes = {
                [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = _SpinningCraneKick },
                [2] = { mode = "Sing", value = 2 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = _Jab }
            };
           CreateButton("AoE",1,0)
           AoEModesLoaded = "Brew Monk AoE Modes";
        end
        -- Cooldowns Button
        if CooldownsModesLoaded ~= "Cooldown Modes" then
            CustomCooldownsModes = {
                [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = _InvokeXuen },
                [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 1, icon = _InvokeXuen },
                [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = [[INTERFACE\ICONS\INV_Misc_AhnQirajTrinket_03]] }
            };
           CooldownsModes = CustomCooldownsModes
           CreateButton("Cooldowns",2,0)
           CooldownsModesLoaded = "Cooldown Modes";
        end

        -- Defensive Button
        if DefensiveModesLoaded ~= "Defensive Modes" then
            CustomDefensiveModes = {
                [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Defensive Cooldowns - Adjust in config", highlight = 1, icon = _Guard },
                [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = [[INTERFACE\ICONS\INV_Misc_AhnQirajTrinket_03]] }
            };
            DefensiveModes = CustomDefensiveModes
            CreateButton("Defensive",3,0)
            DefensiveModesLoaded = "Defensive Modes";
        end

     -- Interrupts Button
        if InterruptsModesLoaded ~= "Interrupt Modes" then
            CustomInterruptsModes = {
                [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = _SpearHandStrike },
                [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = [[INTERFACE\ICONS\INV_Misc_AhnQirajTrinket_03]] }
            };
            InterruptsModes = CustomInterruptsModes
            CreateButton("Interrupts",4,0)
            InterruptsModesLoaded = "Interrupt Modes";
        end

        function SpecificToggle(toggle)
            if getValue(toggle) == 1 then
                return IsLeftControlKeyDown();
            elseif getValue(toggle) == 2 then
                return IsLeftShiftKeyDown();
            elseif getValue(toggle) == 3 then
                return IsLeftAltKeyDown();
            elseif getValue(toggle) == 4 then
                return IsRightControlKeyDown();
            elseif getValue(toggle) == 5 then
                return IsRightShiftKeyDown();
            elseif getValue(toggle) == 6 then
                return IsRightAltKeyDown();
            elseif getValue(toggle) == 7 then
                return 1
            end
        end
    end
-- TODO: Switch AOE mode to just single or auto - no need for forced AOE
-- TODO: Add option/switch to assign a keyboard press (like alt or ctrl) to cast barrel throw and ox statue

--[[]]     --[[]]   --[[           ]]   --[[           ]]   --[[           ]]
--[[ ]]   --[[ ]]        --[[ ]]        --[[           ]]   --[[           ]]
--[[           ]]        --[[ ]]        --[[]]                   --[[ ]]
--[[           ]]        --[[ ]]        --[[           ]]        --[[ ]]
--[[]]     --[[]]        --[[ ]]                   --[[]]        --[[ ]]
--[[]]     --[[]]        --[[ ]]        --[[           ]]        --[[ ]]
--[[]]     --[[]]   --[[           ]]   --[[           ]]        --[[ ]]

   function MonkMistToggles()


        -- Healing Button
        if  HealingModesLoaded ~= "Mist Monk Healing Modes" then
            HealingModes = {
                [1] = { mode = "Off", value = 1 , overlay = "Healing Disabled", tip = "Will not allow healing.", highlight = 0, icon = [[INTERFACE\ICONS\INV_Misc_AhnQirajTrinket_03]] },
                [2] = { mode = "On", value = 2 , overlay = "Healing Enabled", tip = "Will allow healing.", highlight = 1, icon = 115151 },
             };
            CreateButton("Healing",1,0);
            HealingModesLoaded = "Mist Monk Healing Modes";
        end
        -- DPS Button
        if  DPSModesLoaded ~= "Mist Monk DPS Modes" then
            DPSModes = {
                [1] = { mode = "Off", value = 1 , overlay = "DPS Disabled", tip = "Will not allow DPSing.", highlight = 0, icon = [[INTERFACE\ICONS\INV_Misc_AhnQirajTrinket_03]] },
                [2] = { mode = "On", value = 2 , overlay = "DPS Enabled", tip = "Will allow DPSing.", highlight = 1, icon = 100787 },
             };
            CreateButton("DPS",0.5,1);
            DPSModesLoaded = "Mist Monk DPS Modes";
        end
        -- Defensive Button
        if  DefensiveModesLoaded ~= "Mist Monk Defensive Modes" then
            DefensiveModes = {
                [1] = { mode = "None", value = 1 , overlay = "Defensive Disabled", tip = "No Defensive Cooldowns will be used.", highlight = 0, icon = [[INTERFACE\ICONS\INV_Misc_AhnQirajTrinket_03]] },
                [2] = { mode = "All", value = 2 , overlay = "Defensive Enabled", tip = "|cffFF0000Includes: \n|cffFFdd11Fortifying Brew.", highlight = 1, icon = 115203 }
            };
            CreateButton("Defensive",2,0);
            DefensiveModesLoaded = "Mist Monk Defensive Modes";
        end
        -- Cooldowns Button
        if  CooldownsModesLoaded ~= "Mist Monk Cooldowns Modes" then
            CooldownsModes = {
                [1] = { mode = "None", value = 1 , overlay = "Cooldowns Disabled", tip = "No cooldowns will be used.", highlight = 0, icon = [[INTERFACE\ICONS\INV_Misc_AhnQirajTrinket_03]] },
                [2] = { mode = "User", value = 2 , overlay = "User Cooldowns Enabled", tip = "Includes config's selected spells.", highlight = 1, icon = [[INTERFACE\ICONS\inv_misc_blackironbomb]] },
                [3] = { mode = "All", value = 3 , overlay = "Cooldowns Enabled", tip = "|cffFF0000Includes: \n|cffFFdd11Revival.", highlight = 1, icon = 115310 }
            };
            CreateButton("Cooldowns",1.5,1);
            CooldownsModesLoaded = "Mist Monk Cooldowns Modes";
        end
        function SpecificToggle(toggle)
            if getValue(toggle) == 1 then
                return IsLeftControlKeyDown();
            elseif getValue(toggle) == 2 then
                return IsLeftShiftKeyDown();
            elseif getValue(toggle) == 3 then
                return IsLeftAltKeyDown();
            elseif getValue(toggle) == 4 then
                return IsRightControlKeyDown();
            elseif getValue(toggle) == 5 then
                return IsRightShiftKeyDown();
            elseif getValue(toggle) == 6 then
                return IsRightAltKeyDown();
            elseif getValue(toggle) == 7 then
                return 1
            end
        end
    end

--[[]]     --[[]]   --[[           ]]   --[[]]     --[[]]   --[[         ]]
--[[]]     --[[]]         --[[]]        --[[  ]]   --[[]]   --[[          ]]
--[[ ]]   --[[ ]]         --[[]]        --[[    ]] --[[]]   --[[]]     --[[]]
--[[           ]]         --[[]]        --[[           ]]   --[[]]     --[[]]
--[[           ]]         --[[]]        --[[           ]]   --[[]]     --[[]]
--[[ ]]   --[[ ]]         --[[]]        --[[]]   --[[  ]]   --[[          ]]
 --[[]]   --[[]]    --[[           ]]   --[[]]     --[[]]   --[[         ]]

    function WindwalkerToggles()
        -- AoE Button
        if AoEModesLoaded ~= "Cute AoE Modes" then
            CustomAoEModes = {
                [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = _SpinningCraneKick},
                [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = _SpinningCraneKick},
                [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = _Jab}
            };
           AoEModes = CustomAoEModes
           CreateButton("AoE",1,0)
           AoEModesLoaded = "Cute AoE Modes";
        end

     -- Cooldowns Button
        if CooldownsModesLoaded ~= "Cute Cooldowns Modes" then
            CustomCooldownsModes = {
                [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = _InvokeXuen},
                [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = _InvokeXuen},
                [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = _InvokeXuen}
            };
           CooldownsModes = CustomCooldownsModes
           CreateButton("Cooldowns",2,0)
           CooldownsModesLoaded = "Cute Cooldowns Modes";
        end

     -- Defensive Button
        if DefensiveModesLoaded ~= "Cute Defensive Modes" then
            CustomDefensiveModes = {
                [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = _DampenHarm},
                [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = _DampenHarm}
            };
            DefensiveModes = CustomDefensiveModes
            CreateButton("Defensive",3,0)
            DefensiveModesLoaded = "Cute Defensive Modes";
        end

     -- Interrupts Button
        if InterruptsModesLoaded ~= "Cute Interrupt Modes" then
            CustomInterruptsModes = {
                [1] = { mode = "On", value = 2 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = _SpearHandStrike},
                [2] = { mode = "Off", value = 1 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = _SpearHandStrike}
            };
            InterruptsModes = CustomInterruptsModes
            CreateButton("Interrupts",4,0)
            InterruptsModesLoaded = "Cute Interrupt Modes";
        end

     -- Storm, Earth, and Fire Button
        if SEFModesLoaded ~= "Cute SEF Modes" then
            CustomSEFModes = {
                [1] = { mode = "On", value = 2 , overlay = "Auto SEF Enabled", tip = "Will cast Storm, Earth, and Fire.", highlight = 1, icon = _StormEarthFire},
                [2] = { mode = "Off", value = 1 , overlay = "Auto SEF Disabled", tip = "Will NOT cast Storm, Earth, and Fire.", highlight = 0, icon = _StormEarthFire}
            };
            SEFModes = CustomSEFModes
            CreateButton("SEF",5,0)
            SEFModesLoaded = "Cute SEF Modes";
        end

     -- Flying Serpent Kick Button
        if FSKModesLoaded ~= "Cute FSK Modes" then
            CustomFSKModes = {
                [1] = { mode = "On", value = 2 , overlay = "Auto FSK Enabled", tip = "Will cast Flying Serpent Kick.", highlight = 1, icon = _FlyingSerpentKick},
                [2] = { mode = "Off", value = 1 , overlay = "Auto FSK Disabled", tip = "Will NOT cast Flying Serpent Kick.", highlight = 0, icon = _FlyingSerpentKick}
            };
            FSKModes = CustomFSKModes
            CreateButton("FSK",6,0)
            FSKModesLoaded = "Cute FSK Modes";
        end

     -- Chi Builder Button
        if BuilderModesLoaded ~= "Cute Chi Builder Modes" then
            CustomBuilderModes = {
                [1] = { mode = "On", value = 2 , overlay = "Chi Builder Enabled", tip = "Generates Chi when out of combat.", highlight = 1, icon = _ExpelHarm},
                [2] = { mode = "Off", value = 1 , overlay = "Chi Builder Disabled", tip = "No Chi will be generated when out of combat.", highlight = 0, icon = _ExpelHarm}
            };
            BuilderModes = CustomBuilderModes
            CreateButton("Builder",7,0)
            BuilderModesLoaded = "Cute Chi Builder Modes";
        end

        function SpecificToggle(toggle)
            if getValue(toggle) == 1 then
                return IsLeftControlKeyDown();
            elseif getValue(toggle) == 2 then
                return IsLeftShiftKeyDown();
            elseif getValue(toggle) == 3 then
                return IsRightControlKeyDown();
            elseif getValue(toggle) == 4 then
                return IsRightShiftKeyDown();
            elseif getValue(toggle) == 5 then
                return IsRightAltKeyDown();
            elseif getValue(toggle) == 6 then
                return false
            end
        end

    --AoE Key Toggle
        if AOETimer == nil then AOETimer = 0; end
        if SpecificToggle("Rotation Mode") and not GetCurrentKeyBoardFocus() and GetTime() - AOETimer > 0.25 then
            AOETimer = GetTime()
            UpdateButton("AoE")
        end

        --Cooldown Key Toggle
        if CDTimer == nil then CDTimer = 0; end
        if SpecificToggle("Cooldown Mode") and not GetCurrentKeyBoardFocus() and GetTime() - CDTimer > 0.25 then
            CDTimer = GetTime()
            UpdateButton("Cooldowns")
        end

        --Defensive Key Toggle
        if DefTimer == nil then DefTimer = 0; end
        if SpecificToggle("Defensive Mode") and not GetCurrentKeyBoardFocus() and GetTime() - DefTimer > 0.25 then
            DefTimer = GetTime()
            UpdateButton("Defensive")
        end

        --Interrupt Key Toggle
        if IntTimer == nil then IntTimer = 0; end
        if SpecificToggle("Interrupt Mode") and not GetCurrentKeyBoardFocus() and GetTime() - IntTimer > 0.25 then
            IntTimer = GetTime()
            UpdateButton("Interrupts")
        end

        --SEF Key Toggle
        if SEFTimer == nil then SEFTimer = 0; end
        if SpecificToggle("SEF Mode") and not GetCurrentKeyBoardFocus() and GetTime() - SEFTimer > 0.25 then
            SEFTimer = GetTime()
            UpdateButton("SEF")
        end

        --FSK Key Toggle
        if FSKTimer == nil then FSKTimer = 0; end
        if SpecificToggle("FSK Mode") and not GetCurrentKeyBoardFocus() and GetTime() - FSKTimer > 0.25 then
            FSKTimer = GetTime()
            UpdateButton("FSK")
        end

        --Chi Key Toggle
        if ChiTimer == nil then ChiTimer = 0; end
        if SpecificToggle("Builder Mode") and not GetCurrentKeyBoardFocus() and GetTime() - ChiTimer > 0.25 then
            ChiTimer = GetTime()
            UpdateButton("Builder")
        end
    end
-- TODO: Add toggle for FoF
-- TODO: Switch AOE mode to just single or auto - no need for forced AOE
-- TODO: Add option/switch to assign a keyboard press (like alt or ctrl) to cast touch of karma and leg sweep




end
