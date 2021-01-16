
NeP.Protected.wowAdvanced = {}
local f = NeP.Protected.wowAdvanced
local g = NeP._G

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

local function handleUnits(param1, param2, ...)
    if validUnitsOM[param1] then
        if validUnitsOM[param2] then
            return g.SetMouseOver(param1), g.SetFocus(param2), ...
        else
            return g.SetMouseOver(param1), param2, ...
        end
    elseif validUnitsOM[param2] then
        return param1, g.SetMouseOver(param2), ...
    end
    return param1, param2, ...
end

local function UnitTagHandler(func)
    return function(...)
        return func(handleUnits(...))
    end
end

local function UnitTagHandlerSecure(func)
    return function(...)
        if func == 'CastSpellByName' then
            print(tostring(g.CallSecureFunction), func, ...)
        end
        return g.CallSecureFunction(func, handleUnits(...))
    end
end

local SecureFunction = function(s)
    return function (...) return g.CallSecureFunction(s, ...) end
end

function f.Load()

    print('test loaded v5')
    NeP.Protected.nPlates = nil

    -- ADD GUID
    g.UnitInRange = UnitTagHandler(_G.UnitInRange)
    g.UnitPlayerControlled = UnitTagHandler(_G.UnitPlayerControlled)
    g.UnitIsVisible = UnitTagHandler(_G.UnitIsVisible)
    g.GetUnitSpeed = UnitTagHandler(_G.GetUnitSpeed)
    g.UnitClass = UnitTagHandler(_G.UnitClass)
    g.UnitIsTappedByPlayer = UnitTagHandler(_G.UnitIsTappedByPlayer)
    g.UnitThreatSituation = UnitTagHandler(_G.UnitThreatSituation)
    g.UnitCanAttack = UnitTagHandler(_G.UnitCanAttack)
    g.GetUnitSpeed = UnitTagHandler(_G.GetUnitSpeed)
    g.UnitCreatureType = UnitTagHandler(_G.UnitCreatureType)
    g.UnitIsDeadOrGhost = UnitTagHandler(_G.UnitIsDeadOrGhost)
    g.UnitDetailedThreatSituation = UnitTagHandler(_G.UnitDetailedThreatSituation)
    g.UnitIsUnit = UnitTagHandler(_G.UnitIsUnit)
    g.UnitHealthMax = UnitTagHandler(_G.UnitHealthMax)
    g.UnitAffectingCombat = UnitTagHandler(_G.UnitAffectingCombat)
    g.UnitReaction = UnitTagHandler(_G.UnitReaction)
    g.UnitIsPlayer = UnitTagHandler(_G.UnitIsPlayer)
    g.UnitIsDead = UnitTagHandler(_G.UnitIsDead)
    g.UnitInParty = UnitTagHandler(_G.UnitInParty)
    g.UnitInRaid = UnitTagHandler(_G.UnitInRaid)
    g.UnitHealth = UnitTagHandler(_G.UnitHealth)
    g.UnitCastingInfo = UnitTagHandler(_G.UnitCastingInfo)
    g.UnitChannelInfo = UnitTagHandler(_G.UnitChannelInfo)
    g.UnitName = UnitTagHandler(_G.UnitName)
    g.UnitBuff = UnitTagHandler(_G.UnitBuff)
    g.UnitDebuff = UnitTagHandler(_G.UnitDebuff)
    g.UnitInPhase = UnitTagHandler(_G.UnitInPhase)
    g.UnitIsFriend = UnitTagHandler(_G.UnitIsFriend)
    g.IsSpellInRange = UnitTagHandler(_G.IsSpellInRange)
    g.UnitClassification = UnitTagHandler(_G.UnitClassification)
    g.UnitAura = UnitTagHandler(_G.UnitAura)
    g.UnitGroupRolesAssigned = UnitTagHandler(_G.UnitGroupRolesAssigned)
    g.SetPortraitTexture = UnitTagHandler(_G.SetPortraitTexture)
    g.UnitXPMax = UnitTagHandler(_G.UnitXPMax)
    g.UnitXP = UnitTagHandler(_G.UnitXP)
    g.UnitUsingVehicle = UnitTagHandler(_G.UnitUsingVehicle)
    g.UnitStat = UnitTagHandler(_G.UnitStat)
    g.UnitSex = UnitTagHandler(_G.UnitSex)
    g.UnitSelectionColor = UnitTagHandler(_G.UnitSelectionColor)
    g.UnitResistance = UnitTagHandler(_G.UnitResistance)
    g.UnitReaction = UnitTagHandler(_G.UnitReaction)
    g.UnitRangedDamage = UnitTagHandler(_G.UnitRangedDamage)
    g.UnitRangedAttackPower = UnitTagHandler(_G.UnitRangedAttackPower)
    g.UnitRangedAttack = UnitTagHandler(_G.UnitRangedAttack)
    g.UnitRace = UnitTagHandler(_G.UnitRace)
    g.UnitPowerType = UnitTagHandler(_G.UnitPowerType)
    g.UnitPowerMax = UnitTagHandler(_G.UnitPowerMax)
    g.UnitPower = UnitTagHandler(_G.UnitPower)
    g.UnitPVPName = UnitTagHandler(_G.UnitPVPName)
    g.UnitPlayerOrPetInRaid = UnitTagHandler(_G.UnitPlayerOrPetInRaid)
    g.UnitPlayerOrPetInParty = UnitTagHandler(_G.UnitPlayerOrPetInParty)
    g.UnitManaMax = UnitTagHandler(_G.UnitManaMax)
    g.UnitMana = UnitTagHandler(_G.UnitMana)
    g.UnitLevel = UnitTagHandler(_G.UnitLevel)
    g.UnitIsTrivial = UnitTagHandler(_G.UnitIsTrivial)
    g.UnitIsTapped = UnitTagHandler(_G.UnitIsTapped)
    g.UnitIsSameServer = UnitTagHandler(_G.UnitIsSameServer)
    g.UnitIsPossessed = UnitTagHandler(_G.UnitIsPossessed)
    g.UnitIsPVPSanctuary = UnitTagHandler(_G.UnitIsPVPSanctuary)
    g.UnitIsPVPFreeForAll = UnitTagHandler(_G.UnitIsPVPFreeForAll)
    g.UnitIsPVP = UnitTagHandler(_G.UnitIsPVP)
    g.UnitIsGhost = UnitTagHandler(_G.UnitIsGhost)
    g.UnitIsFeignDeath = UnitTagHandler(_G.UnitIsFeignDeath)
    g.UnitIsEnemy = UnitTagHandler(_G.UnitIsEnemy)
    g.UnitIsDND = UnitTagHandler(_G.UnitIsDND)
    g.UnitIsCorpse = UnitTagHandler(_G.UnitIsCorpse)
    g.UnitIsConnected = UnitTagHandler(_G.UnitIsConnected)
    g.UnitIsCharmed = UnitTagHandler(_G.UnitIsCharmed)
    g.UnitIsAFK = UnitTagHandler(_G.UnitIsAFK)
    g.UnitIsInMyGuild = UnitTagHandler(_G.UnitIsInMyGuild)
    g.UnitInBattleground = UnitTagHandler(_G.UnitInBattleground)
    g.GetPlayerInfoByGUID = UnitTagHandler(_G.GetPlayerInfoByGUID)
    g.UnitDefense = UnitTagHandler(_G.UnitDefense)
    g.UnitDamage = UnitTagHandler(_G.UnitDamage)
    g.UnitCreatureType = UnitTagHandler(_G.UnitCreatureType)
    g.UnitCreatureFamily = UnitTagHandler(_G.UnitCreatureFamily)
    g.UnitClass = UnitTagHandler(_G.UnitClass)
    g.UnitCanCooperate = UnitTagHandler(_G.UnitCanCooperate)
    g.UnitCanAttack = UnitTagHandler(_G.UnitCanAttack)
    g.UnitCanAssist = UnitTagHandler(_G.UnitCanAssist)
    g.UnitAttackSpeed = UnitTagHandler(_G.UnitAttackSpeed)
    g.UnitAttackPower = UnitTagHandler(_G.UnitAttackPower)
    g.UnitAttackBothHands = UnitTagHandler(_G.UnitAttackBothHands)
    g.UnitArmor = UnitTagHandler(_G.UnitArmor)
    g.InviteUnit = UnitTagHandler(_G.InviteUnit)
    g.GetUnitSpeed = UnitTagHandler(_G.GetUnitSpeed)
    g.GetUnitPitch = UnitTagHandler(_G.GetUnitPitch)
    g.GetUnitName = UnitTagHandler(_G.GetUnitName)
    g.FollowUnit = UnitTagHandler(_G.FollowUnit)
    g.CheckInteractDistance = UnitTagHandler(_G.CheckInteractDistance)
    g.InitiateTrade = UnitTagHandler(_G.InitiateTrade)
    g.UnitOnTaxi = UnitTagHandler(_G.UnitOnTaxi)
    g.AssistUnit = UnitTagHandler(_G.AssistUnit)
    g.SpellTargetUnit = UnitTagHandler(_G.SpellTargetUnit)
    g.SpellCanTargetUnit = UnitTagHandler(_G.SpellCanTargetUnit)
    g.CombatTextSetActiveUnit = UnitTagHandler(_G.CombatTextSetActiveUnit)
    g.SummonFriend = UnitTagHandler(_G.SummonFriend)
    g.CanSummonFriend = UnitTagHandler(_G.CanSummonFriend)
    g.GrantLevel = UnitTagHandler(_G.GrantLevel)
    g.CanGrantLevel = UnitTagHandler(_G.CanGrantLevel)
    g.SetRaidTarget = UnitTagHandler(_G.SetRaidTarget)
    g.GetReadyCheckStatus = UnitTagHandler(_G.GetReadyCheckStatus)
    g.GetRaidTargetIndex = UnitTagHandler(_G.GetRaidTargetIndex)
    g.GetPartyAssignment = UnitTagHandler(_G.GetPartyAssignment)
    g.DemoteAssistant = UnitTagHandler(_G.DemoteAssistant)
    g.PromoteToAssistant = UnitTagHandler(_G.PromoteToAssistant)
    g.IsUnitOnQuest = UnitTagHandler(_G.IsUnitOnQuest)
    g.DropItemOnUnit = UnitTagHandler(_G.DropItemOnUnit)
    g.GetDefaultLanguage = UnitTagHandler(_G.GetDefaultLanguage)
    g.GetCritChanceFromAgility = UnitTagHandler(_G.GetCritChanceFromAgility)
    g.GetSpellCritChanceFromIntellect = UnitTagHandler(_G.GetSpellCritChanceFromIntellect)

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
    g.UnitCombatReach = function(unit) g.ObjectField(unit, Offsets.CombatReach, 15) end
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
f.Macro = function(...) return g.RunMacroText(...) end
f.UseItem = function(...) return g.UseItemByName(...) end
f.UseInvItem = function(...) return g.UseInventoryItem(...) end
f.TargetUnit = function(...) return g.TargetUnit(...) end
f.SpellStopCasting = function(...) return g.SpellStopCasting(...) end
f.Cast = function(...) return g.CastSpellByName(...) end
f.ObjectGUID = function(...) return g.UnitGUID(...) end
f.ObjectExists = function(...) return g.UnitExists(...) end
f.UnitName = function(...) return g.ObjectName(...) end

function f.CastGround(spell, target)
    if not spell then return end
    -- fallback to generic if we can cast it using macros
    if NeP.Protected.validGround[target] then
        return NeP.Protected.Generic.CastGround(spell, target)
    end
    f.Cast(spell)
    g.ClickPosition(g.GetUnitPosition(target or 'player'))
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
    local aGUID = g.UnitGUID(a)
    local bGUID = g.UnitGUID(b)

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
    validUnitsOM = {}
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
