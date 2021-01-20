
NeP.Protected.wowAdvanced = {}
local f = NeP.Protected.wowAdvanced
local g = NeP._G
local unpack = unpack

local validUnitsOM = {}

local Offsets = {
    ["BoundingRadius"] = 0x1CD4,
    ["CombatReach"] = 0x1CD8, --BoundingRadius + 4 --
    ["SpecID"] = 0x224c,
    ["SummonedBy"] = 0x1c10,
    ["CreatedBy"] = 0x1c20, --SummonedBy + 10
    ['Target'] = 0x1c40,
    ["CastingTarget"] = 0x4C8,
    ["DynamicFlags"] = 0x5e8,
    ['UnitFlag'] = 0x1C40,
    ['LocationX'] = 0x650, --X
    ['LocationY'] = 0x654, --Y
    ['LocationZ'] = 0x658, --z
    ['RotationR'] = 0x650 + 0x10, --Location + 1
}


NeP.Listener:Add('nep_wowadvanced_reset','UPDATE_MOUSEOVER_UNIT', function(...)
	print(...)
end)

local function handleUnits(...)
    local mouseover;
    local focus;
    local args = {...}
    for k, v in pairs(args) do
        if validUnitsOM[v] then
            if not mouseover then
                args[k] = g.SetMouseOver(v)
                mouseover = true
            elseif not focus then
                args[k] = g.SetFocus(v)
                focus = true
            end
        end
    end
    return unpack(args)
end

local function UnitTagHandler(func)
    return function(...)
        local k1, k2, k3, k4, k5 = ... -- 5 should be enough xD
        local key = (k1 or '') .. (k2 or '') .. (k3 or '') .. (k4 or '') .. (k5 or '')
        local cache_api = NeP.Cache.cached_funcs_unlocker[func]
        if not cache_api then
            NeP.Cache.cached_funcs_unlocker[func] = {}
            cache_api = NeP.Cache.cached_funcs_unlocker[func]
        end
        local found = cache_api[key]
        if found then
            return unpack(found)
        end
        cache_api[key] = {_G[func](handleUnits(...))}
        return unpack(cache_api[key])
    end
end

local function UnitTagHandlerSecure(func)
    return function(...)
        return g.CallSecureFunction(func, handleUnits(...))
    end
end

local SecureFunction = function(s)
    return function (...) return g.CallSecureFunction(s, ...) end
end

function f.Load()

    NeP.Protected.nPlates = nil

    print('loaded test WA v10')
    NeP.Cache.cached_funcs_unlocker = {}


    -- lets try to cache ObjectPosition
    NeP.Cache.GetUnitPosition = NeP.Cache.GetUnitPosition or {}
    local old_GetUnitPosition = g.GetUnitPosition
    g.GetUnitPosition = function(unit)
        if not unit then
            return nil
        end
        local found = NeP.Cache.GetUnitPosition[unit]
        if found then
            return unpack(found)
        end
        local x, y, z = old_GetUnitPosition(unit)
        if x then
            NeP.Cache.GetUnitPosition[unit] = {x, y, z}
        end
        return x, y, z
    end

    -- lets try to cache UnitCombatReach
    NeP.Cache.UnitCombatReach = NeP.Cache.UnitCombatReach or {}
    g.UnitCombatReach = function(unit)
        if not unit then
            return nil
        end
        local found = NeP.Cache.UnitCombatReach[unit]
        if found then
            return found
        end
        local reach = g.ObjectField(unit, Offsets.CombatReach, 10)
        if reach then
            NeP.Cache.UnitCombatReach[unit] = reach
        end
        return reach
    end

    -- lets try to cache ObjectType
    NeP.Cache.ObjectType = NeP.Cache.ObjectType or {}
    local old_ObjectType = g.ObjectType
    g.ObjectType = function(unit)
        if not unit then
            return nil
        end
        local found = NeP.Cache.ObjectType[unit]
        if found then
            return found
        end
        local result = old_ObjectType(unit)
        if result then
            NeP.Cache.ObjectType[unit] = result
        end
        return result
    end

    -- lets try to cache UnitFacing
    NeP.Cache.UnitFacing = NeP.Cache.UnitFacing or {}
    local old_UnitFacing = g.UnitFacing
    g.UnitFacing = function(unit)
        if not unit then
            return nil
        end
        local found = NeP.Cache.UnitFacing[unit]
        if found then
            return found
        end
        local result = old_UnitFacing(unit)
        if result then
            NeP.Cache.UnitFacing[unit] = result
        end
        return result
    end

    g.UnitInRange = UnitTagHandler('UnitInRange')
    g.UnitPlayerControlled = UnitTagHandler('UnitPlayerControlled')
    g.UnitIsVisible = UnitTagHandler('UnitIsVisible')
    g.GetUnitSpeed = UnitTagHandler('GetUnitSpeed')
    g.UnitClass = UnitTagHandler('UnitClass')
    g.UnitIsTappedByPlayer = UnitTagHandler('UnitIsTappedByPlayer')
    g.UnitThreatSituation = UnitTagHandler('UnitThreatSituation')
    g.UnitCanAttack = UnitTagHandler('UnitCanAttack')
    g.GetUnitSpeed = UnitTagHandler('GetUnitSpeed')
    g.UnitCreatureType = UnitTagHandler('UnitCreatureType')
    g.UnitIsDeadOrGhost = UnitTagHandler('UnitIsDeadOrGhost')
    g.UnitDetailedThreatSituation = UnitTagHandler('UnitDetailedThreatSituation')
    g.UnitIsUnit = UnitTagHandler('UnitIsUnit')
    g.UnitHealthMax = UnitTagHandler('UnitHealthMax')
    g.UnitAffectingCombat = UnitTagHandler('UnitAffectingCombat')
    g.UnitReaction = UnitTagHandler('UnitReaction')
    g.UnitIsPlayer = UnitTagHandler('UnitIsPlayer')
    g.UnitIsDead = UnitTagHandler('UnitIsDead')
    g.UnitInParty = UnitTagHandler('UnitInParty')
    g.UnitInRaid = UnitTagHandler('UnitInRaid')
    g.UnitHealth = UnitTagHandler('UnitHealth')
    g.UnitCastingInfo = UnitTagHandler('UnitCastingInfo')
    g.UnitChannelInfo = UnitTagHandler('UnitChannelInfo')
    g.UnitName = UnitTagHandler('UnitName')
    g.UnitBuff = UnitTagHandler('UnitBuff')
    g.UnitDebuff = UnitTagHandler('UnitDebuff')
    g.UnitInPhase = UnitTagHandler('UnitInPhase')
    g.UnitIsFriend = UnitTagHandler('UnitIsFriend')
    g.IsSpellInRange = UnitTagHandler('IsSpellInRange')
    g.UnitClassification = UnitTagHandler('UnitClassification')
    g.UnitAura = UnitTagHandler('UnitAura')
    g.UnitGroupRolesAssigned = UnitTagHandler('UnitGroupRolesAssigned')
    g.SetPortraitTexture = UnitTagHandler('SetPortraitTexture')
    g.UnitXPMax = UnitTagHandler('UnitXPMax')
    g.UnitXP = UnitTagHandler('UnitXP')
    g.UnitUsingVehicle = UnitTagHandler('UnitUsingVehicle')
    g.UnitStat = UnitTagHandler('UnitStat')
    g.UnitSex = UnitTagHandler('UnitSex')
    g.UnitSelectionColor = UnitTagHandler('UnitSelectionColor')
    g.UnitResistance = UnitTagHandler('UnitResistance')
    g.UnitReaction = UnitTagHandler('UnitReaction')
    g.UnitRangedDamage = UnitTagHandler('UnitRangedDamage')
    g.UnitRangedAttackPower = UnitTagHandler('UnitRangedAttackPower')
    g.UnitRangedAttack = UnitTagHandler('UnitRangedAttack')
    g.UnitRace = UnitTagHandler('UnitRace')
    g.UnitPowerType = UnitTagHandler('UnitPowerType')
    g.UnitPowerMax = UnitTagHandler('UnitPowerMax')
    g.UnitPower = UnitTagHandler('UnitPower')
    g.UnitPVPName = UnitTagHandler('UnitPVPName')
    g.UnitPlayerOrPetInRaid = UnitTagHandler('UnitPlayerOrPetInRaid')
    g.UnitPlayerOrPetInParty = UnitTagHandler('UnitPlayerOrPetInParty')
    g.UnitManaMax = UnitTagHandler('UnitManaMax')
    g.UnitMana = UnitTagHandler('UnitMana')
    g.UnitLevel = UnitTagHandler('UnitLevel')
    g.UnitIsTrivial = UnitTagHandler('UnitIsTrivial')
    g.UnitIsTapped = UnitTagHandler('UnitIsTapped')
    g.UnitIsSameServer = UnitTagHandler('UnitIsSameServer')
    g.UnitIsPossessed = UnitTagHandler('UnitIsPossessed')
    g.UnitIsPVPSanctuary = UnitTagHandler('UnitIsPVPSanctuary')
    g.UnitIsPVPFreeForAll = UnitTagHandler('UnitIsPVPFreeForAll')
    g.UnitIsPVP = UnitTagHandler('UnitIsPVP')
    g.UnitIsGhost = UnitTagHandler('UnitIsGhost')
    g.UnitIsFeignDeath = UnitTagHandler('UnitIsFeignDeath')
    g.UnitIsEnemy = UnitTagHandler('UnitIsEnemy')
    g.UnitIsDND = UnitTagHandler('UnitIsDND')
    g.UnitIsCorpse = UnitTagHandler('UnitIsCorpse')
    g.UnitIsConnected = UnitTagHandler('UnitIsConnected')
    g.UnitIsCharmed = UnitTagHandler('UnitIsCharmed')
    g.UnitIsAFK = UnitTagHandler('UnitIsAFK')
    g.UnitIsInMyGuild = UnitTagHandler('UnitIsInMyGuild')
    g.UnitInBattleground = UnitTagHandler('UnitInBattleground')
    g.GetPlayerInfoByGUID = UnitTagHandler('GetPlayerInfoByGUID')
    g.UnitDefense = UnitTagHandler('UnitDefense')
    g.UnitDamage = UnitTagHandler('UnitDamage')
    g.UnitCreatureType = UnitTagHandler('UnitCreatureType')
    g.UnitCreatureFamily = UnitTagHandler('UnitCreatureFamily')
    g.UnitClass = UnitTagHandler('UnitClass')
    g.UnitCanCooperate = UnitTagHandler('UnitCanCooperate')
    g.UnitCanAttack = UnitTagHandler('UnitCanAttack')
    g.UnitCanAssist = UnitTagHandler('UnitCanAssist')
    g.UnitAttackSpeed = UnitTagHandler('UnitAttackSpeed')
    g.UnitAttackPower = UnitTagHandler('UnitAttackPower')
    g.UnitAttackBothHands = UnitTagHandler('UnitAttackBothHands')
    g.UnitArmor = UnitTagHandler('UnitArmor')
    g.InviteUnit = UnitTagHandler('InviteUnit')
    g.GetUnitSpeed = UnitTagHandler('GetUnitSpeed')
    g.GetUnitPitch = UnitTagHandler('GetUnitPitch')
    g.GetUnitName = UnitTagHandler('GetUnitName')
    g.FollowUnit = UnitTagHandler('FollowUnit')
    g.CheckInteractDistance = UnitTagHandler('CheckInteractDistance')
    g.InitiateTrade = UnitTagHandler('InitiateTrade')
    g.UnitOnTaxi = UnitTagHandler('UnitOnTaxi')
    g.AssistUnit = UnitTagHandler('AssistUnit')
    g.SpellTargetUnit = UnitTagHandler('SpellTargetUnit')
    g.SpellCanTargetUnit = UnitTagHandler('SpellCanTargetUnit')
    g.CombatTextSetActiveUnit = UnitTagHandler('CombatTextSetActiveUnit')
    g.SummonFriend = UnitTagHandler('SummonFriend')
    g.CanSummonFriend = UnitTagHandler('CanSummonFriend')
    g.GrantLevel = UnitTagHandler('GrantLevel')
    g.CanGrantLevel = UnitTagHandler('CanGrantLevel')
    g.SetRaidTarget = UnitTagHandler('SetRaidTarget')
    g.GetReadyCheckStatus = UnitTagHandler('GetReadyCheckStatus')
    g.GetRaidTargetIndex = UnitTagHandler('GetRaidTargetIndex')
    g.GetPartyAssignment = UnitTagHandler('GetPartyAssignment')
    g.DemoteAssistant = UnitTagHandler('DemoteAssistant')
    g.PromoteToAssistant = UnitTagHandler('PromoteToAssistant')
    g.IsUnitOnQuest = UnitTagHandler('IsUnitOnQuest')
    g.DropItemOnUnit = UnitTagHandler('DropItemOnUnit')
    g.GetDefaultLanguage = UnitTagHandler('GetDefaultLanguage')
    g.GetCritChanceFromAgility = UnitTagHandler('GetCritChanceFromAgility')
    g.GetSpellCritChanceFromIntellect = UnitTagHandler('GetSpellCritChanceFromIntellect')
    g.UnitGetTotalHealAbsorbs = UnitTagHandler('UnitGetTotalHealAbsorbs')
    g.UnitGetIncomingHeals = UnitTagHandler('UnitGetIncomingHeals')

    --PROTECTED with units
    g.CastSpellByName = UnitTagHandlerSecure('CastSpellByName')
    g.CastSpellByID = UnitTagHandlerSecure('CastSpellByID')
    g.UseItemByName = UnitTagHandlerSecure('UseItemByName')
    g.SpellIsTargeting = UnitTagHandlerSecure('SpellIsTargeting')
    g.InteractUnit = UnitTagHandlerSecure('InteractUnit')
    g.CancelUnitBuff = UnitTagHandlerSecure('CancelUnitBuff')

    -- Portected
    g.RunMacroText = SecureFunction('RunMacroText')
    g.TargetUnit = SecureFunction('TargetUnit')
    g.UseInventoryItem = SecureFunction('UseInventoryItem')
    g.SpellStopCasting = SecureFunction('SpellStopCasting')
    g.CameraOrSelectOrMoveStart = SecureFunction('CameraOrSelectOrMoveStart')
    g.CameraOrSelectOrMoveStop = SecureFunction('CameraOrSelectOrMoveStop')
    g.CancelShapeshiftForm = SecureFunction('CancelShapeshiftForm')
    g.PetAssistMode = SecureFunction('PetAssistMode')
    g.PetPassiveMode = SecureFunction('PetPassiveMode')
    g.SpellStopCasting = SecureFunction('SpellStopCasting')
    g.SpellStopTargeting = SecureFunction('SpellStopTargeting')
    g.AscendStop = SecureFunction('AscendStop')
    g.JumpOrAscendStart = SecureFunction('JumpOrAscendStart')
    g.JumpOrAscendStop = SecureFunction('JumpOrAscendStop')
    g.MoveBackwardStart = SecureFunction('MoveBackwardStart')
    g.MoveBackwardStop = SecureFunction('MoveBackwardStop')
    g.MoveForwardStart = SecureFunction('MoveForwardStart')
    g.StrafeLeftStart = SecureFunction('StrafeLeftStart')
    g.StrafeLeftStop = SecureFunction('StrafeLeftStop')
    g.StrafeRightStart = SecureFunction('StrafeRightStart')
    g.StrafeRightStop = SecureFunction('StrafeRightStop')
    g.TurnLeftStart = SecureFunction('TurnLeftStart')
    g.TurnLeftStop = SecureFunction('TurnLeftStop')
    g.TurnRightStart = SecureFunction('TurnRightStart')
    g.TurnRightStop = SecureFunction('TurnRightStop')
    g.PitchUpStart = SecureFunction('PitchUpStart')
    g.PitchDownStart = SecureFunction('PitchDownStart')
    g.PitchDownStop = SecureFunction('PitchDownStop')
    g.ClearTarget = SecureFunction('ClearTarget')
    g.AcceptProposal = SecureFunction('AcceptProposal')
    g.CastPetAction = SecureFunction('CastPetAction')
    g.CastShapeshiftForm = SecureFunction('CastShapeshiftForm')
    g.CastSpell = SecureFunction('CastSpell')
    g.ChangeActionBarPage = SecureFunction('ChangeActionBarPage')
    g.ClearOverrideBindings = SecureFunction('ClearOverrideBindings')
    g.CreateMacro = SecureFunction('CreateMacro')
    g.DeleteCursorItem = SecureFunction('DeleteCursorItem')
    g.DeleteMacro = SecureFunction('DeleteMacro')
    g.DescendStop = SecureFunction('DescendStop')
    g.DestroyTotem = SecureFunction('DestroyTotem')
    g.FocusUnit = SecureFunction('FocusUnit')
    g.ForceQuit = SecureFunction('ForceQuit')
    g.GetUnscaledFrameRect = SecureFunction('GetUnscaledFrameRect')
    g.GuildControlSetRank = SecureFunction('GuildControlSetRank')
    g.GuildControlSetRankFlag = SecureFunction('GuildControlSetRankFlag')
    g.GuildDemote = SecureFunction('GuildDemote')
    g.GuildPromote = SecureFunction('GuildPromote')
    g.GuildUninvite = SecureFunction('GuildUninvite')
    g.JoinBattlefield = SecureFunction('JoinBattlefield')
    g.JumpOrAscendStart = SecureFunction('JumpOrAscendStart')
    g.Logout = SecureFunction('Logout')
    g.MoveBackwardStart = SecureFunction('MoveBackwardStart')
    g.MoveBackwardStop = SecureFunction('MoveBackwardStop')
    g.MoveForwardStart = SecureFunction('MoveForwardStart')
    g.MoveForwardStop = SecureFunction('MoveForwardStop')
    g.PetAssistMode = SecureFunction('PetAssistMode')
    g.PetAttack = SecureFunction('PetAttack')
    g.PetDefensiveAssistMode = SecureFunction('PetDefensiveAssistMode')
    g.PetDefensiveMode = SecureFunction('PetDefensiveMode')
    g.PetFollow = SecureFunction('PetFollow')
    g.PetStopAttack = SecureFunction('PetStopAttack')
    g.PetWait = SecureFunction('PetWait')
    g.PickupAction = SecureFunction('PickupAction')
    g.PickupCompanion = SecureFunction('PickupCompanion')
    g.PickupMacro = SecureFunction('PickupMacro')
    g.PickupPetAction = SecureFunction('PickupPetAction')
    g.PickupSpell = SecureFunction('PickupSpell')
    g.PickupSpellBookItem = SecureFunction('PickupSpellBookItem')
    g.Quit = SecureFunction('Quit')
    g.Region_GetBottom = SecureFunction('Region_GetBottom')
    g.Region_GetCenter = SecureFunction('Region_GetCenter')
    g.Region_GetPoint = SecureFunction('Region_GetPoint')
    g.Region_GetRect = SecureFunction('Region_GetRect')
    g.Region_Hide = SecureFunction('Region_Hide')
    g.Region_SetPoint = SecureFunction('Region_SetPoint')
    g.Region_Show = SecureFunction('Region_Show')
    g.RegisterForSave = SecureFunction('RegisterForSave')
    g.ReplaceEnchant = SecureFunction('ReplaceEnchant')
    g.ReplaceTradeEnchant = SecureFunction('ReplaceTradeEnchant')
    g.RunMacro = SecureFunction('RunMacro')
    g.SendChatMessage = SecureFunction('SendChatMessage')
    g.SetBinding = SecureFunction('SetBinding')
    g.SetBindingClick = SecureFunction('SetBindingClick')
    g.SetBindingItem = SecureFunction('SetBindingItem')
    g.SetBindingMacro = SecureFunction('SetBindingMacro')
    g.SetBindingSpell = SecureFunction('SetBindingSpell')
    g.SetCurrentTitle = SecureFunction('SetCurrentTitle')
    g.SetMoveEnabled = SecureFunction('SetMoveEnabled')
    g.SetOverrideBinding = SecureFunction('SetOverrideBinding')
    g.SetOverrideBindingClick = SecureFunction('SetOverrideBindingClick')
    g.SetOverrideBindingItem = SecureFunction('SetOverrideBindingItem')
    g.SetOverrideBindingMacro = SecureFunction('SetOverrideBindingMacro')
    g.SetOverrideBindingSpell = SecureFunction('SetOverrideBindingSpell')
    g.SetTurnEnabled = SecureFunction('SetTurnEnabled')
    g.ShowUIPanel = SecureFunction('ShowUIPanel')
    g.SitStandOrDescendStart = SecureFunction('SitStandOrDescendStart')
    g.Stuck = SecureFunction('Stuck')
    g.SwapRaidSubgroup = SecureFunction('SwapRaidSubgroup')
    g.TargetLastEnemy = SecureFunction('TargetLastEnemy')
    g.TargetLastTarget = SecureFunction('TargetLastTarget')
    g.TargetNearestEnemy = SecureFunction('TargetNearestEnemy')
    g.TargetNearestFriend = SecureFunction('TargetNearestFriend')
    g.ToggleAutoRun = SecureFunction('ToggleAutoRun')
    g.ToggleRun = SecureFunction('ToggleRun')
    g.TurnOrActionStart = SecureFunction('TurnOrActionStart')
    g.TurnOrActionStop = SecureFunction('TurnOrActionStop')
    g.UIObject_SetForbidden = SecureFunction('UIObject_SetForbidden')
    g.UninviteUnit = SecureFunction('UninviteUnit')
    g.UseAction = SecureFunction('UseAction')
    g.UseContainerItem = SecureFunction('UseContainerItem')
    g.UseToy = SecureFunction('UseToy')
    g.UseToyByName = SecureFunction('UseToyByName')
    g.AcceptBattlefieldPort = SecureFunction('AcceptBattlefieldPort')
    g.AcceptProposal = SecureFunction('AcceptProposal')
    g.AcceptTrade = SecureFunction('AcceptTrade')
    g.AttackTarget = SecureFunction('AttackTarget')
    g.CancelItemTempEnchantment = SecureFunction('CancelItemTempEnchantment')
    g.CancelLogout = SecureFunction('CancelLogout')

    --g.C_AuctionHouse.PostCommodity = SecureFunction('C_AuctionHouse.PostCommodity', ...) end
    --g.C_AuctionHouse.PostItem = SecureFunction('C_AuctionHouse.PostItem', ...) end
    --g.C_AuctionHouse.SearchForFavorites = SecureFunction('C_AuctionHouse.SearchForFavorites', ...) end
    --g.C_AuctionHouse.SendSearchQuery = SecureFunction('C_AuctionHouse.SendSearchQuery', ...) end
    --g.C_AuctionHouse.StartCommoditiesPurchase = SecureFunction('C_AuctionHouse.StartCommoditiesPurchase', ...) end
    --g.C_BlackMarket.ItemPlaceBid = SecureFunction('C_BlackMarket.ItemPlaceBid', ...) end
    --g.C_Calendar.AddEvent = SecureFunction('C_Calendar.AddEvent', ...) end
    --g.C_Calendar.UpdateEvent = SecureFunction('C_Calendar.UpdateEvent', ...) end
    --g.C_Club.CreateTicket = SecureFunction('C_Club.CreateTicket', ...) end
    --g.C_Club.SendCharacterInvitation = SecureFunction('C_Club.SendCharacterInvitation', ...) end
    --g.C_Club.SendInvitation = SecureFunction('C_Club.SendInvitation', ...) end
    --g.C_Club.SendMessage = SecureFunction('C_Club.SendMessage', ...) end
    --g.C_CovenantSanctumUI.DepositAnima = SecureFunction('C_CovenantSanctumUI.DepositAnima', ...) end
    --g.C_EquipmentSet.UseEquipmentSet = SecureFunction('C_EquipmentSet.UseEquipmentSet', ...) end
    --g.C_FriendList.SendWho = SecureFunction('C_FriendList.SendWho', ...) end
    --g.C_LFGList.ApplyToGroup = SecureFunction('C_LFGList.ApplyToGroup', ...) end
    --g.C_LFGList.ClearSearchResults = SecureFunction('C_LFGList.ClearSearchResults', ...) end
    --g.C_LFGList.CreateListing = SecureFunction('C_LFGList.CreateListing', ...) end
    --g.C_LFGList.RemoveListing = SecureFunction('C_LFGList.RemoveListing', ...) end
    --g.C_LFGList.Search = SecureFunction('C_LFGList.Search', ...) end
    --g.C_PetBattles.SkipTurn = SecureFunction('C_PetBattles.SkipTurn', ...) end
    --g.C_PetBattles.UseAbility = SecureFunction('C_PetBattles.UseAbility', ...) end
    --g.C_PetBattles.UseTrap = SecureFunction('C_PetBattles.UseTrap', ...) end
    --g.C_PetJournal.PickupPet = SecureFunction('C_PetJournal.PickupPet', ...) end
    --g.C_PetJournal.SummonPetByGUID = SecureFunction('C_PetJournal.SummonPetByGUID', ...) end
    --g.C_ReportSystem.InitiateReportPlayer = SecureFunction('C_ReportSystem.InitiateReportPlayer', ...) end
    --g.C_ReportSystem.SendReportPlayer = SecureFunction('C_ReportSystem.SendReportPlayer', ...) end
    --g.C_Social.TwitterCheckStatus = SecureFunction('C_Social.TwitterCheckStatus', ...) end
    --g.C_Social.TwitterConnect = SecureFunction('C_Social.TwitterConnect', ...) end
    --g.C_Social.TwitterDisconnect = SecureFunction('C_Social.TwitterDisconnect', ...) end
    --g.C_UI.Reload = SecureFunction('C_UI.Reload', ...) end

    g.UnitGUID = function(Obj)
        if not Obj then
            return nil
        end
        if validUnitsOM[Obj] then
            return Obj
        end
        return _G.UnitGUID(Obj)
    end
    g.UnitExists = function(Obj)
        if not Obj then
            return false
        end
        if validUnitsOM[Obj] then
            return true
        end
        return _G.UnitExists(Obj)
    end
    g.ObjectExists = g.UnitExists
    g.ObjectPosition = g.GetUnitPosition
    g.GetObjectPosition = g.GetUnitPosition
    g.UnitTarget = function(unit) return unit and (((g.IsGuid(unit) and g.SetMouseOver(unit) ) or unit) .. 'target') or nil end
    g.ObjectIsVisible = g.UnitIsVisible
    g.WorldToScreenRaw = g.WorldToScreen;
    g.WorldToScreen = function (wX, wY, wZ)
        local multiplier = UIParent:GetScale()
        local sX, sY = NeP._G.WorldToScreenRaw(wX, wY, wZ)
        return sX * multiplier, sY * multiplier * -1 + WorldFrame:GetTop()
    end

end

-- rapid
f.ObjectGUID = function(unit) return g.UnitGUID(unit) end
f.ObjectExists = function(unit) return g.UnitExists(unit) end
f.UnitName = function(unit) return g.ObjectName(unit) end

function f.Cast(spell, target)
	g.CastSpellByName(spell, target)
end

function f.Macro(text)
	g.RunMacroText(text)
end

function f.UseItem(name, target)
	g.UseItemByName(name, target)
end

function f.UseInvItem(name)
	g.UseInventoryItem(name)
end

function f.TargetUnit(target)
	g.TargetUnit(target)
end

function f.SpellStopCasting()
	g.SpellStopCasting()
end

function f.ResetAfk()
	g.ResetHardwareAction()
end

function f.CastGround(spell, target)
    -- fallback to generic if we can cast it using macros
	if NeP.Protected.validGround[target] then
        return f.Macro("/cast [@"..target.."]"..spell)
    end
    if not NeP.DSL:Get('exists')(target) then return end
    -- Need to know if the spell comes from a Item for use UseItemByName or CastSpellByName
	local IsItem = g.GetItemSpell(spell)
	local func = IsItem and f.UseItem or f.Cast
	local oX, oY, oZ = g.ObjectPosition(target)
	local rX, rY = math.random(), math.random()
	if oX then
		oX = oX + rX;
        oY = oY + rY
		local i = -100
		func(spell)
        local mouselookup = g.IsMouseButtonDown(2)
        if mouselookup then g.MouselookStop() end
        while g.SpellIsTargeting() and i <= 100 do
            g.ClickPosition(oX, oY, oZ)
            i = i + 1
            oZ = i
        end
        if mouselookup then g.MouselookStart() end
        if i >= 100 and g.SpellIsTargeting() then
            g.SpellStopTargeting()
        end
    end
end

function f.Distance(a, b)

    if not NeP.DSL:Get('exists')(a) or not NeP.DSL:Get('exists')(b) then
        return 999
    end

    local ax, ay, az = g.GetUnitPosition(a) -- 'Attacker'
    local bx, by, bz = g.GetUnitPosition(b) -- 'Defender'
    if ax == nil or bx == nil then return math.huge end
	local dx, dy, dz = ax-bx, ay-by, az-bz
	return math.sqrt(dx*dx + dy*dy + dz*dz)
end

function f.UnitCombatRange(a, b)
    if not NeP.DSL:Get('exists')(a) or not NeP.DSL:Get('exists')(b) then
        return 999
    end
    local reachA = g.UnitCombatReach(a) or 1.5
    local reachB = g.UnitCombatReach(b) or 1.5
    local distance = NeP.DSL:Get('distance')(a, nil, b) or 0
    return distance - (reachA + reachB)
end

function f.Infront(a, b)

    if not g.UnitIsVisible(a) or not g.UnitIsVisible(b) then return false end

    local degrees = 90
    local angle1 = g.UnitFacing(a)
    local angle2 = g.UnitFacing(b)
    local calculatedAngle = 999

    local Y1, X1, Z1 = g.GetUnitPosition(a)
    local Y2, X2, Z2 = g.GetUnitPosition(b)
    if Y1 and X1 and Z1 and angle1 and Y2 and X2 and Z2 and angle2 then
        local deltaY = Y2 - Y1
        local deltaX = X2 - X1
        angle1 = math.deg(math.abs(angle1 - math.pi * 2))
        if deltaX > 0 then
            angle2 = math.deg(math.atan(deltaY / deltaX) + (math.pi / 2) +
                                  math.pi)
        elseif deltaX < 0 then
            angle2 = math.deg(math.atan(deltaY / deltaX) + (math.pi / 2))
        end
        if angle2 - angle1 > 180 then
            calculatedAngle = math.abs(angle2 - angle1 - 360)
        elseif angle1 - angle2 > 180 then
            calculatedAngle = math.abs(angle1 - angle2 - 360)
        else
            calculatedAngle = math.abs(angle2 - angle1)
        end
    end

    return calculatedAngle <= degrees
end

function f.LineOfSight(a, b)

    if not a or not b then return false end

    -- Make Sure the Unit Exists
    local aGUID = NeP.DSL:Get('guid')(a)
    local bGUID = NeP.DSL:Get('guid')(b)

    if aGUID == bGUID then return true end

    -- skip if its a boss
    local aID = tonumber(aGUID:match("-(%d+)-%x+$"), 10)
    local bID = tonumber(bGUID:match("-(%d+)-%x+$"), 10)
    if NeP.BossID:Eval(aID) or NeP.BossID:Eval(bID) then return true end

    -- contiunue
    local ax, ay, az = g.GetUnitPosition(a)
    local bx, by, bz = g.GetUnitPosition(b)

    if ax and ay and az and bx and by and bz then
	    local flags = bit.bor(0x10, 0x100, 0x1)
        return (g.TraceLine(ax, ay, az + 2.25, bx, by, bz + 2.25, flags) == 0)
    end
    return false
end

local ObjectTypes = {
    Object = 0,
    Item = 1,
    Container = 2,
    AzeriteEmpoweredItem = 3,
    AzeriteItem = 4,
    Unit = 5,
    Player = 6,
    ActivePlayer = 7,
    GameObject = 8,
    DynamicObject = 9,
    Corpse = 10,
    AreaTrigger = 11,
    SceneObject = 12,
    Conversation = 13
}

function f.GameObjectIsAnimating(a)
	if not g.ObjectExists(a) then
		return false
	end
	local animationState = g.ObjectField(a, 0x60, 3)
	return animationState ~= nil and animationState > 0
end

function f.OM_Maker()
    table.wipe(validUnitsOM)
    for i = 1, g.GetObjectCount() do
        local Obj = g.GetObjectWithIndex(i)
        validUnitsOM[Obj] = true;
        NeP.OM:Add(Obj, g.ObjectType(Obj) == ObjectTypes.GameObject, g.ObjectType(Obj) == ObjectTypes.AreaTrigger)
    end
end

f.ObjectCreator = function(Obj)
    if not g.ObjectExists(Obj) then
		return nil
	end
    return g.ObjectField(Obj, 0x720, 15)
end

NeP.Protected:AddUnlocker('WowAdvanced', {
    test = function() return NeP._G.CallSecureFunction ~= nil end,
    init = f.Load,
    prio = 9,
    functions = f
})
