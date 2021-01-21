
local NeP = NeP -- just for luacheck...

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

local SecureFunction = function(s)
    return function (...) return g.CallSecureFunction(s, ...) end
end

function f.Load()

    NeP.Protected.nPlates = nil

    print('loaded test WA v13')
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

    g.UnitInRange = SecureFunction('UnitInRange')
    g.UnitPlayerControlled = SecureFunction('UnitPlayerControlled')
    g.UnitIsVisible = SecureFunction('UnitIsVisible')
    g.GetUnitSpeed = SecureFunction('GetUnitSpeed')
    g.UnitClass = SecureFunction('UnitClass')
    g.UnitIsTappedByPlayer = SecureFunction('UnitIsTappedByPlayer')
    g.UnitThreatSituation = SecureFunction('UnitThreatSituation')
    g.UnitCanAttack = SecureFunction('UnitCanAttack')
    g.GetUnitSpeed = SecureFunction('GetUnitSpeed')
    g.UnitCreatureType = SecureFunction('UnitCreatureType')
    g.UnitIsDeadOrGhost = SecureFunction('UnitIsDeadOrGhost')
    g.UnitDetailedThreatSituation = SecureFunction('UnitDetailedThreatSituation')
    g.UnitIsUnit = SecureFunction('UnitIsUnit')
    g.UnitHealthMax = SecureFunction('UnitHealthMax')
    g.UnitAffectingCombat = SecureFunction('UnitAffectingCombat')
    g.UnitReaction = SecureFunction('UnitReaction')
    g.UnitIsPlayer = SecureFunction('UnitIsPlayer')
    g.UnitIsDead = SecureFunction('UnitIsDead')
    g.UnitInParty = SecureFunction('UnitInParty')
    g.UnitInRaid = SecureFunction('UnitInRaid')
    g.UnitHealth = SecureFunction('UnitHealth')
    g.UnitCastingInfo = SecureFunction('UnitCastingInfo')
    g.UnitChannelInfo = SecureFunction('UnitChannelInfo')
    g.UnitName = SecureFunction('UnitName')
    g.UnitBuff = SecureFunction('UnitBuff')
    g.UnitDebuff = SecureFunction('UnitDebuff')
    g.UnitInPhase = SecureFunction('UnitInPhase')
    g.UnitIsFriend = SecureFunction('UnitIsFriend')
    g.IsSpellInRange = SecureFunction('IsSpellInRange')
    g.UnitClassification = SecureFunction('UnitClassification')
    g.UnitAura = SecureFunction('UnitAura')
    g.UnitGroupRolesAssigned = SecureFunction('UnitGroupRolesAssigned')
    g.SetPortraitTexture = SecureFunction('SetPortraitTexture')
    g.UnitXPMax = SecureFunction('UnitXPMax')
    g.UnitXP = SecureFunction('UnitXP')
    g.UnitUsingVehicle = SecureFunction('UnitUsingVehicle')
    g.UnitStat = SecureFunction('UnitStat')
    g.UnitSex = SecureFunction('UnitSex')
    g.UnitSelectionColor = SecureFunction('UnitSelectionColor')
    g.UnitResistance = SecureFunction('UnitResistance')
    g.UnitReaction = SecureFunction('UnitReaction')
    g.UnitRangedDamage = SecureFunction('UnitRangedDamage')
    g.UnitRangedAttackPower = SecureFunction('UnitRangedAttackPower')
    g.UnitRangedAttack = SecureFunction('UnitRangedAttack')
    g.UnitRace = SecureFunction('UnitRace')
    g.UnitPowerType = SecureFunction('UnitPowerType')
    g.UnitPowerMax = SecureFunction('UnitPowerMax')
    g.UnitPower = SecureFunction('UnitPower')
    g.UnitPVPName = SecureFunction('UnitPVPName')
    g.UnitPlayerOrPetInRaid = SecureFunction('UnitPlayerOrPetInRaid')
    g.UnitPlayerOrPetInParty = SecureFunction('UnitPlayerOrPetInParty')
    g.UnitManaMax = SecureFunction('UnitManaMax')
    g.UnitMana = SecureFunction('UnitMana')
    g.UnitLevel = SecureFunction('UnitLevel')
    g.UnitIsTrivial = SecureFunction('UnitIsTrivial')
    g.UnitIsTapped = SecureFunction('UnitIsTapped')
    g.UnitIsSameServer = SecureFunction('UnitIsSameServer')
    g.UnitIsPossessed = SecureFunction('UnitIsPossessed')
    g.UnitIsPVPSanctuary = SecureFunction('UnitIsPVPSanctuary')
    g.UnitIsPVPFreeForAll = SecureFunction('UnitIsPVPFreeForAll')
    g.UnitIsPVP = SecureFunction('UnitIsPVP')
    g.UnitIsGhost = SecureFunction('UnitIsGhost')
    g.UnitIsFeignDeath = SecureFunction('UnitIsFeignDeath')
    g.UnitIsEnemy = SecureFunction('UnitIsEnemy')
    g.UnitIsDND = SecureFunction('UnitIsDND')
    g.UnitIsCorpse = SecureFunction('UnitIsCorpse')
    g.UnitIsConnected = SecureFunction('UnitIsConnected')
    g.UnitIsCharmed = SecureFunction('UnitIsCharmed')
    g.UnitIsAFK = SecureFunction('UnitIsAFK')
    g.UnitIsInMyGuild = SecureFunction('UnitIsInMyGuild')
    g.UnitInBattleground = SecureFunction('UnitInBattleground')
    g.GetPlayerInfoByGUID = SecureFunction('GetPlayerInfoByGUID')
    g.UnitDefense = SecureFunction('UnitDefense')
    g.UnitDamage = SecureFunction('UnitDamage')
    g.UnitCreatureType = SecureFunction('UnitCreatureType')
    g.UnitCreatureFamily = SecureFunction('UnitCreatureFamily')
    g.UnitClass = SecureFunction('UnitClass')
    g.UnitCanCooperate = SecureFunction('UnitCanCooperate')
    g.UnitCanAttack = SecureFunction('UnitCanAttack')
    g.UnitCanAssist = SecureFunction('UnitCanAssist')
    g.UnitAttackSpeed = SecureFunction('UnitAttackSpeed')
    g.UnitAttackPower = SecureFunction('UnitAttackPower')
    g.UnitAttackBothHands = SecureFunction('UnitAttackBothHands')
    g.UnitArmor = SecureFunction('UnitArmor')
    g.InviteUnit = SecureFunction('InviteUnit')
    g.GetUnitSpeed = SecureFunction('GetUnitSpeed')
    g.GetUnitPitch = SecureFunction('GetUnitPitch')
    g.GetUnitName = SecureFunction('GetUnitName')
    g.FollowUnit = SecureFunction('FollowUnit')
    g.CheckInteractDistance = SecureFunction('CheckInteractDistance')
    g.InitiateTrade = SecureFunction('InitiateTrade')
    g.UnitOnTaxi = SecureFunction('UnitOnTaxi')
    g.AssistUnit = SecureFunction('AssistUnit')
    g.SpellTargetUnit = SecureFunction('SpellTargetUnit')
    g.SpellCanTargetUnit = SecureFunction('SpellCanTargetUnit')
    g.CombatTextSetActiveUnit = SecureFunction('CombatTextSetActiveUnit')
    g.SummonFriend = SecureFunction('SummonFriend')
    g.CanSummonFriend = SecureFunction('CanSummonFriend')
    g.GrantLevel = SecureFunction('GrantLevel')
    g.CanGrantLevel = SecureFunction('CanGrantLevel')
    g.SetRaidTarget = SecureFunction('SetRaidTarget')
    g.GetReadyCheckStatus = SecureFunction('GetReadyCheckStatus')
    g.GetRaidTargetIndex = SecureFunction('GetRaidTargetIndex')
    g.GetPartyAssignment = SecureFunction('GetPartyAssignment')
    g.DemoteAssistant = SecureFunction('DemoteAssistant')
    g.PromoteToAssistant = SecureFunction('PromoteToAssistant')
    g.IsUnitOnQuest = SecureFunction('IsUnitOnQuest')
    g.DropItemOnUnit = SecureFunction('DropItemOnUnit')
    g.GetDefaultLanguage = SecureFunction('GetDefaultLanguage')
    g.GetCritChanceFromAgility = SecureFunction('GetCritChanceFromAgility')
    g.GetSpellCritChanceFromIntellect = SecureFunction('GetSpellCritChanceFromIntellect')
    g.UnitGetTotalHealAbsorbs = SecureFunction('UnitGetTotalHealAbsorbs')
    g.UnitGetIncomingHeals = SecureFunction('UnitGetIncomingHeals')

    --PROTECTED with units
    g.CastSpellByName = SecureFunction('CastSpellByName')
    g.CastSpellByID = SecureFunction('CastSpellByID')
    g.UseItemByName = SecureFunction('UseItemByName')
    g.SpellIsTargeting = SecureFunction('SpellIsTargeting')
    g.InteractUnit = SecureFunction('InteractUnit')
    g.CancelUnitBuff = SecureFunction('CancelUnitBuff')
    g.TargetUnit = SecureFunction('TargetUnit')

    -- Portected
    g.RunMacroText = SecureFunction('RunMacroText')
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
