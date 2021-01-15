local _, gbl = ...
local NeP = _G.NeP
gbl.Wownet = {}
local f = gbl.Wownet
local g = gbl.gapis

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

--[[local function UnitTagHandler(func, ...)

    local mouseover;
    local focus;
    local args = {...}

    for k, v in pairs(args) do
        if v and validUnitsOM[v] then
            if not mouseover then
                args[k] = g.SetMouseOver(v)
                mouseover = true
            elseif not focus then
                args[k] = g.SetFocusTarget(v)
                focus = true
            end
        end
    end

    return func(unpack(args))
end]]

local UnitTagHandler = function(func, param1, param2, ...)
    if validUnitsOM[param1] then
        if validUnitsOM[param2] then
            return func(g.SetMouseOver(param1), g.SetFocus(param2),...)
        else
            return func(g.SetMouseOver(param1), param2,...)
        end
    else
        if validUnitsOM[param2] then
            return func(param1, g.SetMouseOver(param2),...)
        else
            return func(param1, param2,...)
        end
    end
end

function f.Load()

    print('LOADED test v4')

    -- ADD GUID
    g.UnitInRange = function(...) return UnitTagHandler(_G.UnitInRange, ...) end
    g.UnitPlayerControlled = function(...) return UnitTagHandler(_G.UnitPlayerControlled, ...) end
    g.UnitIsVisible = function(...) return UnitTagHandler(_G.UnitIsVisible, ...) end
    g.GetUnitSpeed = function(...) return UnitTagHandler(_G.GetUnitSpeed, ...) end
    g.UnitClass = function(...) return UnitTagHandler(_G.UnitClass, ...) end
    g.UnitIsTappedByPlayer = function(...) return UnitTagHandler(_G.UnitIsTappedByPlayer, ...) end
    g.UnitThreatSituation = function(...) return UnitTagHandler(_G.UnitThreatSituation, ...) end
    g.UnitCanAttack = function(...) return UnitTagHandler(_G.UnitCanAttack, ...) end
    g.GetUnitSpeed = function(...) return UnitTagHandler(_G.GetUnitSpeed, ...) end
    g.UnitCreatureType = function(...) return UnitTagHandler(_G.UnitCreatureType, ...) end
    g.UnitIsDeadOrGhost = function(...) return UnitTagHandler(_G.UnitIsDeadOrGhost, ...) end
    g.UnitDetailedThreatSituation = function(...) return UnitTagHandler(_G.UnitDetailedThreatSituation, ...) end
    g.UnitIsUnit = function(...) return UnitTagHandler(_G.UnitIsUnit, ...) end
    g.UnitHealthMax = function(...) return UnitTagHandler(_G.UnitHealthMax, ...) end
    g.UnitAffectingCombat = function(...) return UnitTagHandler(_G.UnitAffectingCombat, ...) end
    g.UnitReaction = function(...) return UnitTagHandler(_G.UnitReaction, ...) end
    g.UnitIsPlayer = function(...) return UnitTagHandler(_G.UnitIsPlayer, ...) end
    g.UnitIsDead = function(...) return UnitTagHandler(_G.UnitIsDead, ...) end
    g.UnitInParty = function(...) return UnitTagHandler(_G.UnitInParty, ...) end
    g.UnitInRaid = function(...) return UnitTagHandler(_G.UnitInRaid, ...) end
    g.UnitHealth = function(...) return UnitTagHandler(_G.UnitHealth, ...) end
    g.UnitCastingInfo = function(...) return UnitTagHandler(_G.UnitCastingInfo, ...) end
    g.UnitChannelInfo = function(...) return UnitTagHandler(_G.UnitChannelInfo, ...) end
    g.UnitName = function(...) return UnitTagHandler(_G.UnitName, ...) end
    g.UnitBuff = function(...) return UnitTagHandler(_G.UnitBuff, ...) end
    g.UnitDebuff = function(...) return UnitTagHandler(_G.UnitDebuff, ...) end
    g.UnitInPhase = function(...) return UnitTagHandler(_G.UnitInPhase, ...) end
    g.UnitIsFriend = function(...) return UnitTagHandler(_G.UnitIsFriend, ...) end
    g.IsSpellInRange = function(...) return UnitTagHandler(_G.IsSpellInRange, ...) end
    g.UnitClassification = function(...) return UnitTagHandler(_G.UnitClassification, ...) end
    g.UnitAura = function(...) return UnitTagHandler(_G.UnitAura, ...) end
    g.UnitGroupRolesAssigned = function(...) return UnitTagHandler(_G.UnitGroupRolesAssigned, ...) end
    g.SetPortraitTexture = function(...) return UnitTagHandler(_G.SetPortraitTexture, ...) end
    g.UnitXPMax = function(...) return UnitTagHandler(_G.UnitXPMax, ...) end
    g.UnitXP = function(...) return UnitTagHandler(_G.UnitXP, ...) end
    g.UnitUsingVehicle = function(...) return UnitTagHandler(_G.UnitUsingVehicle, ...) end
    g.UnitStat = function(...) return UnitTagHandler(_G.UnitStat, ...) end
    g.UnitSex = function(...) return UnitTagHandler(_G.UnitSex, ...) end
    g.UnitSelectionColor = function(...) return UnitTagHandler(_G.UnitSelectionColor, ...) end
    g.UnitResistance = function(...) return UnitTagHandler(_G.UnitResistance, ...) end
    g.UnitReaction = function(...) return UnitTagHandler(_G.UnitReaction, ...) end
    g.UnitRangedDamage = function(...) return UnitTagHandler(_G.UnitRangedDamage, ...) end
    g.UnitRangedAttackPower = function(...) return UnitTagHandler(_G.UnitRangedAttackPower, ...) end
    g.UnitRangedAttack = function(...) return UnitTagHandler(_G.UnitRangedAttack, ...) end
    g.UnitRace = function(...) return UnitTagHandler(_G.UnitRace, ...) end
    g.UnitPowerType = function(...) return UnitTagHandler(_G.UnitPowerType, ...) end
    g.UnitPowerMax = function(...) return UnitTagHandler(_G.UnitPowerMax, ...) end
    g.UnitPower = function(...) return UnitTagHandler(_G.UnitPower, ...) end
    g.UnitPVPName = function(...) return UnitTagHandler(_G.UnitPVPName, ...) end
    g.UnitPlayerOrPetInRaid = function(...) return UnitTagHandler(_G.UnitPlayerOrPetInRaid, ...) end
    g.UnitPlayerOrPetInParty = function(...) return UnitTagHandler(_G.UnitPlayerOrPetInParty, ...) end
    g.UnitManaMax = function(...) return UnitTagHandler(_G.UnitManaMax, ...) end
    g.UnitMana = function(...) return UnitTagHandler(_G.UnitMana, ...) end
    g.UnitLevel = function(...) return UnitTagHandler(_G.UnitLevel, ...) end
    g.UnitIsTrivial = function(...) return UnitTagHandler(_G.UnitIsTrivial, ...) end
    g.UnitIsTapped = function(...) return UnitTagHandler(_G.UnitIsTapped, ...) end
    g.UnitIsSameServer = function(...) return UnitTagHandler(_G.UnitIsSameServer, ...) end
    g.UnitIsPossessed = function(...) return UnitTagHandler(_G.UnitIsPossessed, ...) end
    g.UnitIsPVPSanctuary = function(...) return UnitTagHandler(_G.UnitIsPVPSanctuary, ...) end
    g.UnitIsPVPFreeForAll = function(...) return UnitTagHandler(_G.UnitIsPVPFreeForAll, ...) end
    g.UnitIsPVP = function(...) return UnitTagHandler(_G.UnitIsPVP, ...) end
    g.UnitIsGhost = function(...) return UnitTagHandler(_G.UnitIsGhost, ...) end
    g.UnitIsFeignDeath = function(...) return UnitTagHandler(_G.UnitIsFeignDeath, ...) end
    g.UnitIsEnemy = function(...) return UnitTagHandler(_G.UnitIsEnemy, ...) end
    g.UnitIsDND = function(...) return UnitTagHandler(_G.UnitIsDND, ...) end
    g.UnitIsCorpse = function(...) return UnitTagHandler(_G.UnitIsCorpse, ...) end
    g.UnitIsConnected = function(...) return UnitTagHandler(_G.UnitIsConnected, ...) end
    g.UnitIsCharmed = function(...) return UnitTagHandler(_G.UnitIsCharmed, ...) end
    g.UnitIsAFK = function(...) return UnitTagHandler(_G.UnitIsAFK, ...) end
    g.UnitIsInMyGuild = function(...) return UnitTagHandler(_G.UnitIsInMyGuild, ...) end
    g.UnitInBattleground = function(...) return UnitTagHandler(_G.UnitInBattleground, ...) end
    g.GetPlayerInfoByGUID = function(...) return UnitTagHandler(_G.GetPlayerInfoByGUID, ...) end
    g.UnitDefense = function(...) return UnitTagHandler(_G.UnitDefense, ...) end
    g.UnitDamage = function(...) return UnitTagHandler(_G.UnitDamage, ...) end
    g.UnitCreatureType = function(...) return UnitTagHandler(_G.UnitCreatureType, ...) end
    g.UnitCreatureFamily = function(...) return UnitTagHandler(_G.UnitCreatureFamily, ...) end
    g.UnitClass = function(...) return UnitTagHandler(_G.UnitClass, ...) end
    g.UnitCanCooperate = function(...) return UnitTagHandler(_G.UnitCanCooperate, ...) end
    g.UnitCanAttack = function(...) return UnitTagHandler(_G.UnitCanAttack, ...) end
    g.UnitCanAssist = function(...) return UnitTagHandler(_G.UnitCanAssist, ...) end
    g.UnitAttackSpeed = function(...) return UnitTagHandler(_G.UnitAttackSpeed, ...) end
    g.UnitAttackPower = function(...) return UnitTagHandler(_G.UnitAttackPower, ...) end
    g.UnitAttackBothHands = function(...) return UnitTagHandler(_G.UnitAttackBothHands, ...) end
    g.UnitArmor = function(...) return UnitTagHandler(_G.UnitArmor, ...) end
    g.InviteUnit = function(...) return UnitTagHandler(_G.InviteUnit, ...) end
    g.GetUnitSpeed = function(...) return UnitTagHandler(_G.GetUnitSpeed, ...) end
    g.GetUnitPitch = function(...) return UnitTagHandler(_G.GetUnitPitch, ...) end
    g.GetUnitName = function(...) return UnitTagHandler(_G.GetUnitName, ...) end
    g.FollowUnit = function(...) return UnitTagHandler(_G.FollowUnit, ...) end
    g.CheckInteractDistance = function(...) return UnitTagHandler(_G.CheckInteractDistance, ...) end
    g.InitiateTrade = function(...) return UnitTagHandler(_G.InitiateTrade, ...) end
    g.UnitOnTaxi = function(...) return UnitTagHandler(_G.UnitOnTaxi, ...) end
    g.AssistUnit = function(...) return UnitTagHandler(_G.AssistUnit, ...) end
    g.SpellTargetUnit = function(...) return UnitTagHandler(_G.SpellTargetUnit, ...) end
    g.SpellCanTargetUnit = function(...) return UnitTagHandler(_G.SpellCanTargetUnit, ...) end
    g.CombatTextSetActiveUnit = function(...) return UnitTagHandler(_G.CombatTextSetActiveUnit, ...) end
    g.SummonFriend = function(...) return UnitTagHandler(_G.SummonFriend, ...) end
    g.CanSummonFriend = function(...) return UnitTagHandler(_G.CanSummonFriend, ...) end
    g.GrantLevel = function(...) return UnitTagHandler(_G.GrantLevel, ...) end
    g.CanGrantLevel = function(...) return UnitTagHandler(_G.CanGrantLevel, ...) end
    g.SetRaidTarget = function(...) return UnitTagHandler(_G.SetRaidTarget, ...) end
    g.GetReadyCheckStatus = function(...) return UnitTagHandler(_G.GetReadyCheckStatus, ...) end
    g.GetRaidTargetIndex = function(...) return UnitTagHandler(_G.GetRaidTargetIndex, ...) end
    g.GetPartyAssignment = function(...) return UnitTagHandler(_G.GetPartyAssignment, ...) end
    g.DemoteAssistant = function(...) return UnitTagHandler(_G.DemoteAssistant, ...) end
    g.PromoteToAssistant = function(...) return UnitTagHandler(_G.PromoteToAssistant, ...) end
    g.IsUnitOnQuest = function(...) return UnitTagHandler(_G.IsUnitOnQuest, ...) end
    g.DropItemOnUnit = function(...) return UnitTagHandler(_G.DropItemOnUnit, ...) end
    g.GetDefaultLanguage = function(...) return UnitTagHandler(_G.GetDefaultLanguage, ...) end
    g.GetCritChanceFromAgility = function(...) return UnitTagHandler(_G.GetCritChanceFromAgility, ...) end
    g.GetSpellCritChanceFromIntellect = function(...) return UnitTagHandler(_G.GetSpellCritChanceFromIntellect, ...) end


    --PROTECTED with units
    g.CastSpellByName = function(...) return UnitTagHandler(g.CallSecureFunction, 'CastSpellByName', ...) end
    g.CastSpellByID = function(...) return UnitTagHandler(g.CallSecureFunction, 'CastSpellByID', ...) end
    g.UseItemByName = function(...) return UnitTagHandler(g.CallSecureFunction, 'UseItemByName', ...) end
    g.SpellIsTargeting = function(...) return UnitTagHandler(g.CallSecureFunction, 'SpellIsTargeting', ...) end
    g.InteractUnit = function(...) return UnitTagHandler(g.CallSecureFunction, 'InteractUnit', ...) end
    g.CancelUnitBuff = function(...) return UnitTagHandler(g.CallSecureFunction, 'CancelUnitBuff', ...) end


    -- Portected
    g.RunMacroText = function(...) return g.CallSecureFunction('RunMacroText', ...) end
    g.TargetUnit = function(...) return g.CallSecureFunction('TargetUnit', ...) end
    g.UseInventoryItem = function(...) return g.CallSecureFunction('UseInventoryItem', ...) end
    g.SpellStopCasting = function(...) return g.CallSecureFunction('SpellStopCasting', ...) end
    g.CameraOrSelectOrMoveStart = function(...) return g.CallSecureFunction('CameraOrSelectOrMoveStart', ...) end
    g.CameraOrSelectOrMoveStop = function(...) return g.CallSecureFunction('CameraOrSelectOrMoveStop', ...) end
    g.CancelShapeshiftForm = function(...) return g.CallSecureFunction('CancelShapeshiftForm', ...) end
    g.PetAssistMode = function(...) return g.CallSecureFunction('PetAssistMode', ...) end
    g.PetPassiveMode = function(...) return g.CallSecureFunction('PetPassiveMode', ...) end
    g.SpellStopCasting = function(...) return g.CallSecureFunction('SpellStopCasting', ...) end
    g.SpellStopTargeting = function(...) return g.CallSecureFunction('SpellStopTargeting', ...) end
    g.AscendStop = function(...) return g.CallSecureFunction('AscendStop', ...) end
    g.JumpOrAscendStart = function(...) return g.CallSecureFunction('JumpOrAscendStart', ...) end
    g.JumpOrAscendStop = function(...) return g.CallSecureFunction('JumpOrAscendStop', ...) end
    g.MoveBackwardStart = function(...) return g.CallSecureFunction('MoveBackwardStart', ...) end
    g.MoveBackwardStop = function(...) return g.CallSecureFunction('MoveBackwardStop', ...) end
    g.MoveForwardStart = function(...) return g.CallSecureFunction('MoveForwardStart', ...) end
    g.StrafeLeftStart = function(...) return g.CallSecureFunction('StrafeLeftStart', ...) end
    g.StrafeLeftStop = function(...) return g.CallSecureFunction('StrafeLeftStop', ...) end
    g.StrafeRightStart = function(...) return g.CallSecureFunction('StrafeRightStart', ...) end
    g.StrafeRightStop = function(...) return g.CallSecureFunction('StrafeRightStop', ...) end
    g.TurnLeftStart = function(...) return g.CallSecureFunction('TurnLeftStart', ...) end
    g.TurnLeftStop = function(...) return g.CallSecureFunction('TurnLeftStop', ...) end
    g.TurnRightStart = function(...) return g.CallSecureFunction('TurnRightStart', ...) end
    g.TurnRightStop = function(...) return g.CallSecureFunction('TurnRightStop', ...) end
    g.PitchUpStart = function(...) return g.CallSecureFunction('PitchUpStart', ...) end
    g.PitchDownStart = function(...) return g.CallSecureFunction('PitchDownStart', ...) end
    g.PitchDownStop = function(...) return g.CallSecureFunction('PitchDownStop', ...) end
    g.ClearTarget = function(...) return g.CallSecureFunction('ClearTarget', ...) end
    g.AcceptProposal = function(...) return g.CallSecureFunction('AcceptProposal', ...) end
    g.CastPetAction = function(...) return g.CallSecureFunction('CastPetAction', ...) end
    g.CastShapeshiftForm = function(...) return g.CallSecureFunction('CastShapeshiftForm', ...) end
    g.CastSpell = function(...) return g.CallSecureFunction('CastSpell', ...) end
    g.ChangeActionBarPage = function(...) return g.CallSecureFunction('ChangeActionBarPage', ...) end
    g.ClearOverrideBindings = function(...) return g.CallSecureFunction('ClearOverrideBindings', ...) end
    g.CreateMacro = function(...) return g.CallSecureFunction('CreateMacro', ...) end
    g.DeleteCursorItem = function(...) return g.CallSecureFunction('DeleteCursorItem', ...) end
    g.DeleteMacro = function(...) return g.CallSecureFunction('DeleteMacro', ...) end
    g.DescendStop = function(...) return g.CallSecureFunction('DescendStop', ...) end
    g.DestroyTotem = function(...) return g.CallSecureFunction('DestroyTotem', ...) end
    g.FocusUnit = function(...) return g.CallSecureFunction('FocusUnit', ...) end
    g.ForceQuit = function(...) return g.CallSecureFunction('ForceQuit', ...) end
    g.GetUnscaledFrameRect = function(...) return g.CallSecureFunction('GetUnscaledFrameRect', ...) end
    g.GuildControlSetRank = function(...) return g.CallSecureFunction('GuildControlSetRank', ...) end
    g.GuildControlSetRankFlag = function(...) return g.CallSecureFunction('GuildControlSetRankFlag', ...) end
    g.GuildDemote = function(...) return g.CallSecureFunction('GuildDemote', ...) end
    g.GuildPromote = function(...) return g.CallSecureFunction('GuildPromote', ...) end
    g.GuildUninvite = function(...) return g.CallSecureFunction('GuildUninvite', ...) end
    g.JoinBattlefield = function(...) return g.CallSecureFunction('JoinBattlefield', ...) end
    g.JumpOrAscendStart = function(...) return g.CallSecureFunction('JumpOrAscendStart', ...) end
    g.Logout = function(...) return g.CallSecureFunction('Logout', ...) end
    g.MoveBackwardStart = function(...) return g.CallSecureFunction('MoveBackwardStart', ...) end
    g.MoveBackwardStop = function(...) return g.CallSecureFunction('MoveBackwardStop', ...) end
    g.MoveForwardStart = function(...) return g.CallSecureFunction('MoveForwardStart', ...) end
    g.MoveForwardStop = function(...) return g.CallSecureFunction('MoveForwardStop', ...) end
    g.PetAssistMode = function(...) return g.CallSecureFunction('PetAssistMode', ...) end
    g.PetAttack = function(...) return g.CallSecureFunction('PetAttack', ...) end
    g.PetDefensiveAssistMode = function(...) return g.CallSecureFunction('PetDefensiveAssistMode', ...) end
    g.PetDefensiveMode = function(...) return g.CallSecureFunction('PetDefensiveMode', ...) end
    g.PetFollow = function(...) return g.CallSecureFunction('PetFollow', ...) end
    g.PetStopAttack = function(...) return g.CallSecureFunction('PetStopAttack', ...) end
    g.PetWait = function(...) return g.CallSecureFunction('PetWait', ...) end
    g.PickupAction = function(...) return g.CallSecureFunction('PickupAction', ...) end
    g.PickupCompanion = function(...) return g.CallSecureFunction('PickupCompanion', ...) end
    g.PickupMacro = function(...) return g.CallSecureFunction('PickupMacro', ...) end
    g.PickupPetAction = function(...) return g.CallSecureFunction('PickupPetAction', ...) end
    g.PickupSpell = function(...) return g.CallSecureFunction('PickupSpell', ...) end
    g.PickupSpellBookItem = function(...) return g.CallSecureFunction('PickupSpellBookItem', ...) end
    g.Quit = function(...) return g.CallSecureFunction('Quit', ...) end
    g.Region_GetBottom = function(...) return g.CallSecureFunction('Region_GetBottom', ...) end
    g.Region_GetCenter = function(...) return g.CallSecureFunction('Region_GetCenter', ...) end
    g.Region_GetPoint = function(...) return g.CallSecureFunction('Region_GetPoint', ...) end
    g.Region_GetRect = function(...) return g.CallSecureFunction('Region_GetRect', ...) end
    g.Region_Hide = function(...) return g.CallSecureFunction('Region_Hide', ...) end
    g.Region_SetPoint = function(...) return g.CallSecureFunction('Region_SetPoint', ...) end
    g.Region_Show = function(...) return g.CallSecureFunction('Region_Show', ...) end
    g.RegisterForSave = function(...) return g.CallSecureFunction('RegisterForSave', ...) end
    g.ReplaceEnchant = function(...) return g.CallSecureFunction('ReplaceEnchant', ...) end
    g.ReplaceTradeEnchant = function(...) return g.CallSecureFunction('ReplaceTradeEnchant', ...) end
    g.RunMacro = function(...) return g.CallSecureFunction('RunMacro', ...) end
    g.SendChatMessage = function(...) return g.CallSecureFunction('SendChatMessage', ...) end
    g.SetBinding = function(...) return g.CallSecureFunction('SetBinding', ...) end
    g.SetBindingClick = function(...) return g.CallSecureFunction('SetBindingClick', ...) end
    g.SetBindingItem = function(...) return g.CallSecureFunction('SetBindingItem', ...) end
    g.SetBindingMacro = function(...) return g.CallSecureFunction('SetBindingMacro', ...) end
    g.SetBindingSpell = function(...) return g.CallSecureFunction('SetBindingSpell', ...) end
    g.SetCurrentTitle = function(...) return g.CallSecureFunction('SetCurrentTitle', ...) end
    g.SetMoveEnabled = function(...) return g.CallSecureFunction('SetMoveEnabled', ...) end
    g.SetOverrideBinding = function(...) return g.CallSecureFunction('SetOverrideBinding', ...) end
    g.SetOverrideBindingClick = function(...) return g.CallSecureFunction('SetOverrideBindingClick', ...) end
    g.SetOverrideBindingItem = function(...) return g.CallSecureFunction('SetOverrideBindingItem', ...) end
    g.SetOverrideBindingMacro = function(...) return g.CallSecureFunction('SetOverrideBindingMacro', ...) end
    g.SetOverrideBindingSpell = function(...) return g.CallSecureFunction('SetOverrideBindingSpell', ...) end
    g.SetTurnEnabled = function(...) return g.CallSecureFunction('SetTurnEnabled', ...) end
    g.ShowUIPanel = function(...) return g.CallSecureFunction('ShowUIPanel', ...) end
    g.SitStandOrDescendStart = function(...) return g.CallSecureFunction('SitStandOrDescendStart', ...) end
    g.Stuck = function(...) return g.CallSecureFunction('Stuck', ...) end
    g.SwapRaidSubgroup = function(...) return g.CallSecureFunction('SwapRaidSubgroup', ...) end
    g.TargetLastEnemy = function(...) return g.CallSecureFunction('TargetLastEnemy', ...) end
    g.TargetLastTarget = function(...) return g.CallSecureFunction('TargetLastTarget', ...) end
    g.TargetNearestEnemy = function(...) return g.CallSecureFunction('TargetNearestEnemy', ...) end
    g.TargetNearestFriend = function(...) return g.CallSecureFunction('TargetNearestFriend', ...) end
    g.ToggleAutoRun = function(...) return g.CallSecureFunction('ToggleAutoRun', ...) end
    g.ToggleRun = function(...) return g.CallSecureFunction('ToggleRun', ...) end
    g.TurnOrActionStart = function(...) return g.CallSecureFunction('TurnOrActionStart', ...) end
    g.TurnOrActionStop = function(...) return g.CallSecureFunction('TurnOrActionStop', ...) end
    g.UIObject_SetForbidden = function(...) return g.CallSecureFunction('UIObject_SetForbidden', ...) end
    g.UninviteUnit = function(...) return g.CallSecureFunction('UninviteUnit', ...) end
    g.UseAction = function(...) return g.CallSecureFunction('UseAction', ...) end
    g.UseContainerItem = function(...) return g.CallSecureFunction('UseContainerItem', ...) end
    g.UseToy = function(...) return g.CallSecureFunction('UseToy', ...) end
    g.UseToyByName = function(...) return g.CallSecureFunction('UseToyByName', ...) end
    g.AcceptBattlefieldPort = function(...) return g.CallSecureFunction('AcceptBattlefieldPort', ...) end
    g.AcceptProposal = function(...) return g.CallSecureFunction('AcceptProposal', ...) end
    g.AcceptTrade = function(...) return g.CallSecureFunction('AcceptTrade', ...) end
    g.AttackTarget = function(...) return g.CallSecureFunction('AttackTarget', ...) end
    --g.C_AuctionHouse.PostCommodity = function(...) return g.CallSecureFunction('C_AuctionHouse.PostCommodity', ...) end
    --g.C_AuctionHouse.PostItem = function(...) return g.CallSecureFunction('C_AuctionHouse.PostItem', ...) end
    --g.C_AuctionHouse.SearchForFavorites = function(...) return g.CallSecureFunction('C_AuctionHouse.SearchForFavorites', ...) end
    --g.C_AuctionHouse.SendSearchQuery = function(...) return g.CallSecureFunction('C_AuctionHouse.SendSearchQuery', ...) end
    --g.C_AuctionHouse.StartCommoditiesPurchase = function(...) return g.CallSecureFunction('C_AuctionHouse.StartCommoditiesPurchase', ...) end
    --g.C_BlackMarket.ItemPlaceBid = function(...) return g.CallSecureFunction('C_BlackMarket.ItemPlaceBid', ...) end
    --g.C_Calendar.AddEvent = function(...) return g.CallSecureFunction('C_Calendar.AddEvent', ...) end
    --g.C_Calendar.UpdateEvent = function(...) return g.CallSecureFunction('C_Calendar.UpdateEvent', ...) end
    --g.C_Club.CreateTicket = function(...) return g.CallSecureFunction('C_Club.CreateTicket', ...) end
    --g.C_Club.SendCharacterInvitation = function(...) return g.CallSecureFunction('C_Club.SendCharacterInvitation', ...) end
    --g.C_Club.SendInvitation = function(...) return g.CallSecureFunction('C_Club.SendInvitation', ...) end
    --g.C_Club.SendMessage = function(...) return g.CallSecureFunction('C_Club.SendMessage', ...) end
    --g.C_CovenantSanctumUI.DepositAnima = function(...) return g.CallSecureFunction('C_CovenantSanctumUI.DepositAnima', ...) end
    --g.C_EquipmentSet.UseEquipmentSet = function(...) return g.CallSecureFunction('C_EquipmentSet.UseEquipmentSet', ...) end
    --g.C_FriendList.SendWho = function(...) return g.CallSecureFunction('C_FriendList.SendWho', ...) end
    --g.C_LFGList.ApplyToGroup = function(...) return g.CallSecureFunction('C_LFGList.ApplyToGroup', ...) end
    --g.C_LFGList.ClearSearchResults = function(...) return g.CallSecureFunction('C_LFGList.ClearSearchResults', ...) end
    --g.C_LFGList.CreateListing = function(...) return g.CallSecureFunction('C_LFGList.CreateListing', ...) end
    --g.C_LFGList.RemoveListing = function(...) return g.CallSecureFunction('C_LFGList.RemoveListing', ...) end
    --g.C_LFGList.Search = function(...) return g.CallSecureFunction('C_LFGList.Search', ...) end
    --g.C_PetBattles.SkipTurn = function(...) return g.CallSecureFunction('C_PetBattles.SkipTurn', ...) end
    --g.C_PetBattles.UseAbility = function(...) return g.CallSecureFunction('C_PetBattles.UseAbility', ...) end
    --g.C_PetBattles.UseTrap = function(...) return g.CallSecureFunction('C_PetBattles.UseTrap', ...) end
    --g.C_PetJournal.PickupPet = function(...) return g.CallSecureFunction('C_PetJournal.PickupPet', ...) end
    --g.C_PetJournal.SummonPetByGUID = function(...) return g.CallSecureFunction('C_PetJournal.SummonPetByGUID', ...) end
    --g.C_ReportSystem.InitiateReportPlayer = function(...) return g.CallSecureFunction('C_ReportSystem.InitiateReportPlayer', ...) end
    --g.C_ReportSystem.SendReportPlayer = function(...) return g.CallSecureFunction('C_ReportSystem.SendReportPlayer', ...) end
    --g.C_Social.TwitterCheckStatus = function(...) return g.CallSecureFunction('C_Social.TwitterCheckStatus', ...) end
    --g.C_Social.TwitterConnect = function(...) return g.CallSecureFunction('C_Social.TwitterConnect', ...) end
    --g.C_Social.TwitterDisconnect = function(...) return g.CallSecureFunction('C_Social.TwitterDisconnect', ...) end
    --g.C_UI.Reload = function(...) return g.CallSecureFunction('C_UI.Reload', ...) end
    g.CancelItemTempEnchantment = function(...) return g.CallSecureFunction('CancelItemTempEnchantment', ...) end
    g.CancelLogout = function(...) return g.CallSecureFunction('CancelLogout', ...) end

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

function f.Cast(spell, target)
    g.CastSpellByName(spell, target)
end

function f.CastGround(spell, target)
    if not spell then return end
    -- fallback to generic if we can cast it using macros
    if gbl.validGround[target] then
        return gbl.Generic.CastGround(spell, target)
    end
    f.Cast(spell)
    g.ClickPosition(g.GetUnitPosition(target or 'player'))
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

f.ObjectGUID = function(Obj)
    return g.UnitGUID(Obj)
end

f.ObjectExists = function(Obj)
    return g.UnitExists(Obj)
end

f.UnitName = function(Obj) return g.ObjectName(Obj) end

gbl:AddUnlocker('WowAdvanced', {
    test = function() return NeP._G.CallSecureFunction ~= nil end,
    init = f.Load,
    prio = 9,
    functions = f
})
