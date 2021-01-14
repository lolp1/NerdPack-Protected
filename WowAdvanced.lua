local _, gbl = ...
local NeP = _G.NeP
gbl.Wownet = {}
local f = gbl.Wownet
local g = gbl.gapis

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

local function UnitTagHandler(func, ...)

    local mouseover;
    local focus;
    local args = {...}

    for k, v in pairs(args) do
        if v and not _G.UnitExists(v) and g.IsGuid(v) then
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
end

function f.Load()

    -- ADD GUID
    g.UnitInRange = function(...) UnitTagHandler(_G.UnitInRange, ...) end
    g.UnitPlayerControlled = function(...) UnitTagHandler(_G.UnitPlayerControlled, ...) end
    g.UnitIsVisible = function(...) UnitTagHandler(_G.UnitIsVisible, ...) end
    g.GetUnitSpeed = function(...) UnitTagHandler(_G.GetUnitSpeed, ...) end
    g.UnitClass = function(...) UnitTagHandler(_G.UnitClass, ...) end
    g.UnitIsTappedByPlayer = function(...) UnitTagHandler(_G.UnitIsTappedByPlayer, ...) end
    g.UnitThreatSituation = function(...) UnitTagHandler(_G.UnitThreatSituation, ...) end
    g.UnitCanAttack = function(...) UnitTagHandler(_G.UnitCanAttack, ...) end
    g.GetUnitSpeed = function(...) UnitTagHandler(_G.GetUnitSpeed, ...) end
    g.UnitCreatureType = function(...) UnitTagHandler(_G.UnitCreatureType, ...) end
    g.UnitIsDeadOrGhost = function(...) UnitTagHandler(_G.UnitIsDeadOrGhost, ...) end
    g.UnitDetailedThreatSituation = function(...) UnitTagHandler(_G.UnitDetailedThreatSituation, ...) end
    g.UnitIsUnit = function(...) UnitTagHandler(_G.UnitIsUnit, ...) end
    g.UnitHealthMax = function(...) UnitTagHandler(_G.UnitHealthMax, ...) end
    g.UnitAffectingCombat = function(...) UnitTagHandler(_G.UnitAffectingCombat, ...) end
    g.UnitReaction = function(...) UnitTagHandler(_G.UnitReaction, ...) end
    g.UnitIsPlayer = function(...) UnitTagHandler(_G.UnitIsPlayer, ...) end
    g.UnitIsDead = function(...) UnitTagHandler(_G.UnitIsDead, ...) end
    g.UnitInParty = function(...) UnitTagHandler(_G.UnitInParty, ...) end
    g.UnitInRaid = function(...) UnitTagHandler(_G.UnitInRaid, ...) end
    g.UnitHealth = function(...) UnitTagHandler(_G.UnitHealth, ...) end
    g.UnitCastingInfo = function(...) UnitTagHandler(_G.UnitCastingInfo, ...) end
    g.UnitChannelInfo = function(...) UnitTagHandler(_G.UnitChannelInfo, ...) end
    g.UnitName = function(...) UnitTagHandler(_G.UnitName, ...) end
    g.UnitBuff = function(...) UnitTagHandler(_G.UnitBuff, ...) end
    g.UnitDebuff = function(...) UnitTagHandler(_G.UnitDebuff, ...) end
    g.UnitInPhase = function(...) UnitTagHandler(_G.UnitInPhase, ...) end
    g.UnitIsFriend = function(...) UnitTagHandler(_G.UnitIsFriend, ...) end
    g.IsSpellInRange = function(...) UnitTagHandler(_G.IsSpellInRange, ...) end
    g.UnitClassification = function(...) UnitTagHandler(_G.UnitClassification, ...) end
    g.UnitAura = function(...) UnitTagHandler(_G.UnitAura, ...) end
    g.UnitGroupRolesAssigned = function(...) UnitTagHandler(_G.UnitGroupRolesAssigned, ...) end
    g.SetPortraitTexture = function(...) UnitTagHandler(_G.SetPortraitTexture, ...) end
    g.UnitXPMax = function(...) UnitTagHandler(_G.UnitXPMax, ...) end
    g.UnitXP = function(...) UnitTagHandler(_G.UnitXP, ...) end
    g.UnitUsingVehicle = function(...) UnitTagHandler(_G.UnitUsingVehicle, ...) end
    g.UnitStat = function(...) UnitTagHandler(_G.UnitStat, ...) end
    g.UnitSex = function(...) UnitTagHandler(_G.UnitSex, ...) end
    g.UnitSelectionColor = function(...) UnitTagHandler(_G.UnitSelectionColor, ...) end
    g.UnitResistance = function(...) UnitTagHandler(_G.UnitResistance, ...) end
    g.UnitReaction = function(...) UnitTagHandler(_G.UnitReaction, ...) end
    g.UnitRangedDamage = function(...) UnitTagHandler(_G.UnitRangedDamage, ...) end
    g.UnitRangedAttackPower = function(...) UnitTagHandler(_G.UnitRangedAttackPower, ...) end
    g.UnitRangedAttack = function(...) UnitTagHandler(_G.UnitRangedAttack, ...) end
    g.UnitRace = function(...) UnitTagHandler(_G.UnitRace, ...) end
    g.UnitPowerType = function(...) UnitTagHandler(_G.UnitPowerType, ...) end
    g.UnitPowerMax = function(...) UnitTagHandler(_G.UnitPowerMax, ...) end
    g.UnitPower = function(...) UnitTagHandler(_G.UnitPower, ...) end
    g.UnitPVPName = function(...) UnitTagHandler(_G.UnitPVPName, ...) end
    g.UnitPlayerOrPetInRaid = function(...) UnitTagHandler(_G.UnitPlayerOrPetInRaid, ...) end
    g.UnitPlayerOrPetInParty = function(...) UnitTagHandler(_G.UnitPlayerOrPetInParty, ...) end
    g.UnitManaMax = function(...) UnitTagHandler(_G.UnitManaMax, ...) end
    g.UnitMana = function(...) UnitTagHandler(_G.UnitMana, ...) end
    g.UnitLevel = function(...) UnitTagHandler(_G.UnitLevel, ...) end
    g.UnitIsTrivial = function(...) UnitTagHandler(_G.UnitIsTrivial, ...) end
    g.UnitIsTapped = function(...) UnitTagHandler(_G.UnitIsTapped, ...) end
    g.UnitIsSameServer = function(...) UnitTagHandler(_G.UnitIsSameServer, ...) end
    g.UnitIsPossessed = function(...) UnitTagHandler(_G.UnitIsPossessed, ...) end
    g.UnitIsPVPSanctuary = function(...) UnitTagHandler(_G.UnitIsPVPSanctuary, ...) end
    g.UnitIsPVPFreeForAll = function(...) UnitTagHandler(_G.UnitIsPVPFreeForAll, ...) end
    g.UnitIsPVP = function(...) UnitTagHandler(_G.UnitIsPVP, ...) end
    g.UnitIsGhost = function(...) UnitTagHandler(_G.UnitIsGhost, ...) end
    g.UnitIsFeignDeath = function(...) UnitTagHandler(_G.UnitIsFeignDeath, ...) end
    g.UnitIsEnemy = function(...) UnitTagHandler(_G.UnitIsEnemy, ...) end
    g.UnitIsDND = function(...) UnitTagHandler(_G.UnitIsDND, ...) end
    g.UnitIsCorpse = function(...) UnitTagHandler(_G.UnitIsCorpse, ...) end
    g.UnitIsConnected = function(...) UnitTagHandler(_G.UnitIsConnected, ...) end
    g.UnitIsCharmed = function(...) UnitTagHandler(_G.UnitIsCharmed, ...) end
    g.UnitIsAFK = function(...) UnitTagHandler(_G.UnitIsAFK, ...) end
    g.UnitIsInMyGuild = function(...) UnitTagHandler(_G.UnitIsInMyGuild, ...) end
    g.UnitInBattleground = function(...) UnitTagHandler(_G.UnitInBattleground, ...) end
    g.GetPlayerInfoByGUID = function(...) UnitTagHandler(_G.GetPlayerInfoByGUID, ...) end
    g.UnitDefense = function(...) UnitTagHandler(_G.UnitDefense, ...) end
    g.UnitDamage = function(...) UnitTagHandler(_G.UnitDamage, ...) end
    g.UnitCreatureType = function(...) UnitTagHandler(_G.UnitCreatureType, ...) end
    g.UnitCreatureFamily = function(...) UnitTagHandler(_G.UnitCreatureFamily, ...) end
    g.UnitClass = function(...) UnitTagHandler(_G.UnitClass, ...) end
    g.UnitCanCooperate = function(...) UnitTagHandler(_G.UnitCanCooperate, ...) end
    g.UnitCanAttack = function(...) UnitTagHandler(_G.UnitCanAttack, ...) end
    g.UnitCanAssist = function(...) UnitTagHandler(_G.UnitCanAssist, ...) end
    g.UnitAttackSpeed = function(...) UnitTagHandler(_G.UnitAttackSpeed, ...) end
    g.UnitAttackPower = function(...) UnitTagHandler(_G.UnitAttackPower, ...) end
    g.UnitAttackBothHands = function(...) UnitTagHandler(_G.UnitAttackBothHands, ...) end
    g.UnitArmor = function(...) UnitTagHandler(_G.UnitArmor, ...) end
    g.InviteUnit = function(...) UnitTagHandler(_G.InviteUnit, ...) end
    g.GetUnitSpeed = function(...) UnitTagHandler(_G.GetUnitSpeed, ...) end
    g.GetUnitPitch = function(...) UnitTagHandler(_G.GetUnitPitch, ...) end
    g.GetUnitName = function(...) UnitTagHandler(_G.GetUnitName, ...) end
    g.FollowUnit = function(...) UnitTagHandler(_G.FollowUnit, ...) end
    g.CheckInteractDistance = function(...) UnitTagHandler(_G.CheckInteractDistance, ...) end
    g.InitiateTrade = function(...) UnitTagHandler(_G.InitiateTrade, ...) end
    g.UnitOnTaxi = function(...) UnitTagHandler(_G.UnitOnTaxi, ...) end
    g.AssistUnit = function(...) UnitTagHandler(_G.AssistUnit, ...) end
    g.SpellTargetUnit = function(...) UnitTagHandler(_G.SpellTargetUnit, ...) end
    g.SpellCanTargetUnit = function(...) UnitTagHandler(_G.SpellCanTargetUnit, ...) end
    g.CombatTextSetActiveUnit = function(...) UnitTagHandler(_G.CombatTextSetActiveUnit, ...) end
    g.SummonFriend = function(...) UnitTagHandler(_G.SummonFriend, ...) end
    g.CanSummonFriend = function(...) UnitTagHandler(_G.CanSummonFriend, ...) end
    g.GrantLevel = function(...) UnitTagHandler(_G.GrantLevel, ...) end
    g.CanGrantLevel = function(...) UnitTagHandler(_G.CanGrantLevel, ...) end
    g.SetRaidTarget = function(...) UnitTagHandler(_G.SetRaidTarget, ...) end
    g.GetReadyCheckStatus = function(...) UnitTagHandler(_G.GetReadyCheckStatus, ...) end
    g.GetRaidTargetIndex = function(...) UnitTagHandler(_G.GetRaidTargetIndex, ...) end
    g.GetPartyAssignment = function(...) UnitTagHandler(_G.GetPartyAssignment, ...) end
    g.DemoteAssistant = function(...) UnitTagHandler(_G.DemoteAssistant, ...) end
    g.PromoteToAssistant = function(...) UnitTagHandler(_G.PromoteToAssistant, ...) end
    g.IsUnitOnQuest = function(...) UnitTagHandler(_G.IsUnitOnQuest, ...) end
    g.DropItemOnUnit = function(...) UnitTagHandler(_G.DropItemOnUnit, ...) end
    g.GetDefaultLanguage = function(...) UnitTagHandler(_G.GetDefaultLanguage, ...) end
    g.GetCritChanceFromAgility = function(...) UnitTagHandler(_G.GetCritChanceFromAgility, ...) end
    g.GetSpellCritChanceFromIntellect = function(...) UnitTagHandler(_G.GetSpellCritChanceFromIntellect, ...) end

    --PROTECTED
    g.CastSpellByName = function(...) UnitTagHandler(g.CallSecureFunction, 'CastSpellByName', ...) end
    g.CastSpellByID = function(...) UnitTagHandler(g.CallSecureFunction, 'CastSpellByID', ...) end
    g.UseItemByName = function(...) UnitTagHandler(g.CallSecureFunction, 'UseItemByName', ...) end
    g.RunMacroText = function(...) g.CallSecureFunction('RunMacroText', ...) end
    g.TargetUnit = function(...) g.CallSecureFunction('TargetUnit', ...) end
    g.UseInventoryItem = function(...) g.CallSecureFunction('UseInventoryItem', ...) end
    g.SpellStopCasting = function(...) g.CallSecureFunction('SpellStopCasting', ...) end

    g.UnitGUID = function(Obj) return Obj and (g.IsGuid(Obj) and Obj or _G.UnitGUID(Obj)) or nil end
    g.UnitExists = function(Obj) return Obj and (g.IsGuid(Obj) or _G.UnitGUID(Obj)) or nil end
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

local function ObjectIsType(obj, i) return g.ObjectType(obj) == ObjectTypes[i] end

function f.GameObjectIsAnimating(a)
	if not g.ObjectExists(a) then
		return false
	end
	local animationState = g.ObjectField(a, 0x60, 3)
	return animationState ~= nil and animationState > 0
end

function f.OM_Maker()
    for i = 1, g.GetObjectCount() do
        local Obj = g.GetObjectWithIndex(i)
        if Obj and g.IsGuid(Obj) then
            NeP.OM:Add(Obj, ObjectIsType(Obj, ObjectTypes.GameObject))
        end
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
