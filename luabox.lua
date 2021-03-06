
NeP.Protected.LuaBox = {}
local f = NeP.Protected.LuaBox
local g = NeP._G
local lb

function f.Load()
	NeP.Core:Print('LB is still under dev... v12')
	NeP.Protected.nPlates = nil
    lb = g.__LB__;
	local _G = _G
	g.ReadFile = lb.ReadFile
	g.WriteFile = lb.WriteFile
	g.CameraOrSelectOrMoveStart = function (...) return lb.Unlock(_G.CameraOrSelectOrMoveStart, ...) end
	g.CameraOrSelectOrMoveStop = function (...) return lb.Unlock(_G.CameraOrSelectOrMoveStop, ...) end
	g.CancelShapeshiftForm = function (...) return lb.Unlock(_G.CancelShapeshiftForm, ...) end
	g.CastSpellByID = function (...) return lb.UnitTagHandler(lb.Unlock, _G.CastSpellByID, ...) end
	g.CastSpellByName = function (...) return lb.UnitTagHandler(lb.Unlock, _G.CastSpellByName, ...) end
	g.PetAssistMode = function (...) return lb.Unlock(_G.PetAssistMode, ...) end
	g.PetPassiveMode = function (...) return lb.Unlock(_G.PetPassiveMode, ...) end
	g.RunMacroText = function (...) return  lb.Unlock(_G.RunMacroText, ...); end
	g.SpellIsTargeting = function (...) return lb.UnitTagHandler(lb.Unlock, _G.SpellIsTargeting, ...) end
	g.SpellStopCasting = function (...) return lb.Unlock(_G.SpellStopCasting, ...) end
	g.SpellStopTargeting = function (...) return lb.Unlock(_G.SpellStopTargeting, ...) end
	g.TargetUnit = function (...) return ... and lb.UnitTagHandler(_G.TargetUnit, ...) or false end
	g.UseInventoryItem = function (...) return ... and lb.UnitTagHandler(lb.Unlock, _G.UseInventoryItem, ...) or lb.Unlock(_G.UseInventoryItem, ...) end
    g.UseItemByName = function (...) return ... and lb.UnitTagHandler(lb.Unlock, _G.UseItemByName, ...) or lb.Unlock(_G.UseItemByName, ...) end
	g.CastingInfo = function (...) return lb.UnitTagHandler(_G.CastingInfo, ...) end
	g.ChannelInfo = function (...) return lb.UnitTagHandler(_G.ChannelInfo, ...) end
	g.GetRaidRosterInfo = function (...) return lb.UnitTagHandler(_G.GetRaidRosterInfo, ...) end
	g.GetRaidTargetIndex = function (...) return lb.UnitTagHandler(_G.GetRaidTargetIndex, ...) end
	g.GetUnitSpeed = function (...) return lb.UnitTagHandler(_G.GetUnitSpeed, ...) end
	g.UnitAffectingCombat = function (...) return lb.UnitTagHandler(_G.UnitAffectingCombat, ...) end
	g.UnitCanAttack = function (...) return lb.UnitTagHandler(_G.UnitCanAttack, ...) end
	g.UnitCastingInfo = function (...) return lb.UnitTagHandler(_G.UnitCastingInfo, ...) end
	g.UnitChannelInfo = function (...) return lb.UnitTagHandler(_G.UnitChannelInfo, ...) end
	g.UnitClass = function (...) return lb.UnitTagHandler(_G.UnitClass, ...) end
	g.UnitClassification = function (...) return lb.UnitTagHandler(_G.UnitClassification, ...) end
	g.UnitCreatureType = function (...) return lb.UnitTagHandler(_G.UnitCreatureType, ...) end
	g.UnitDetailedThreatSituation = function (...) return lb.UnitTagHandler(_G.UnitDetailedThreatSituation, ...) end
	g.UnitExists = function (...) return lb.UnitTagHandler(_G.UnitExists, ...) end
	g.UnitGetIncomingHeals = function (...) return lb.UnitTagHandler(_G.UnitGetIncomingHeals, ...) or 0 end
	g.UnitGetTotalHealAbsorbs = function (...) return lb.UnitTagHandler(_G.UnitGetTotalHealAbsorbs, ...) or 0 end
	g.UnitGroupRolesAssigned = function (...) return lb.UnitTagHandler(_G.UnitGroupRolesAssigned, ...) end
	g.UnitGUID = function (...) return lb.UnitTagHandler(_G.UnitGUID, ...) end
	g.UnitHealth = function (...) return lb.UnitTagHandler(_G.UnitHealth, ...) or 100 end
	g.UnitHealthMax = function (...) return lb.UnitTagHandler(_G.UnitHealthMax, ...) or 100 end
    g.UnitInRaid = function (...) return lb.UnitTagHandler(_G.UnitInRaid, ...) end
    g.UnitIsGroupLeader = function (...) return lb.UnitTagHandler(_G.UnitIsGroupLeader, ...) end
    g.UnitInParty = function (...) return lb.UnitTagHandler(_G.UnitInParty, ...) end
    g.UnitPhaseReason = function (...) return lb.UnitTagHandler(_G.UnitPhaseReason, ...) end
	g.UnitIsDead = function (...) return lb.UnitTagHandler(_G.UnitIsDead, ...) end
	g.UnitIsDeadOrGhost = function (...) return lb.UnitTagHandler(_G.UnitIsDeadOrGhost, ...) end
	g.UnitIsGhost = function (...) return lb.UnitTagHandler(_G.UnitIsGhost, ...) end
	g.UnitIsPlayer = function (...) return lb.UnitTagHandler(_G.UnitIsPlayer, ...) end
	g.UnitIsPVP = function (...) return lb.UnitTagHandler(_G.UnitIsPVP, ...) end
	g.UnitIsUnit = function (...) return lb.UnitTagHandler(_G.UnitIsUnit, ...) end
	g.UnitIsVisible = function (...) return lb.UnitTagHandler(_G.UnitIsVisible, ...) end
	g.UnitIsTapDenied = function (...) return lb.UnitTagHandler(_G.UnitIsTapDenied, ...) end
	g.UnitLevel = function (...) return lb.UnitTagHandler(_G.UnitLevel, ...) or 120 end
	g.UnitName = function (...) return lb.UnitTagHandler(_G.UnitName, ...) end
	g.UnitRace = function (...) return lb.UnitTagHandler(_G.UnitRace, ...) end
    g.UnitPlayerOrPetInParty = function (...) return lb.UnitTagHandler(_G.UnitPlayerOrPetInParty , ...) end
    g.UnitIsFriend = function(...) return lb.UnitTagHandler(_G.UnitIsFriend , ...) end
	g.UnitPlayerOrPetInRaid = function (...) return lb.UnitTagHandler(_G.UnitPlayerOrPetInRaid , ...) end
	g.UnitThreatSituation = function (...) return lb.UnitTagHandler(_G.UnitThreatSituation, ...) or 0 end
	g.UnitTarget = function (...) return lb.UnitTagHandler(_G.UnitTarget, ...) end
	g.UnitBuff = function (...) return lb.UnitTagHandler(_G.UnitBuff, ...) end
	g.UnitDebuff = function (...) return lb.UnitTagHandler(_G.UnitDebuff, ...) end
	g.UnitAura = function (...) return lb.UnitTagHandler(_G.UnitAura, ...) end
	g.UnitFactionGroup = function (...) return lb.UnitTagHandler(_G.UnitFactionGroup, ...) end
	g.PetAttack = function (...) return lb.UnitTagHandler(_G.PetAttack, ...) end
	g.IsSpellInRange = function (...) return lb.UnitTagHandler(_G.IsSpellInRange, ...) end
	g.AscendStop = function () return lb.Unlock(_G.AscendStop) end
	g.JumpOrAscendStart = function () return lb.Unlock(_G.JumpOrAscendStart) end
	g.JumpOrAscendStop = function () return lb.Unlock(_G.JumpOrAscendStop) end
	g.MoveBackwardStart = function () return lb.Unlock(_G.MoveBackwardStart) end
	g.MoveBackwardStop = function () return lb.Unlock(_G.MoveBackwardStop) end
	g.MoveForwardStart = function () return lb.Unlock(_G.MoveForwardStart) end
	g.MoveForwardStop = function () return lb.Unlock(_G.MoveForwardStop) end
	g.StrafeLeftStart = function () return lb.Unlock(_G.StrafeLeftStart) end
	g.StrafeLeftStop = function () return lb.Unlock(_G.StrafeLeftStop) end
	g.StrafeRightStart = function () return lb.Unlock(_G.StrafeRightStart) end
	g.StrafeRightStop = function () return lb.Unlock(_G.StrafeRightStop) end
	g.TurnLeftStart = function () return lb.Unlock(_G.TurnLeftStart) end
	g.TurnLeftStop = function () return lb.Unlock(_G.TurnLeftStop) end
	g.TurnRightStart = function () return lb.Unlock(_G.TurnRightStart) end
	g.TurnRightStop = function () return lb.Unlock(_G.TurnRightStop) end
	g.PitchUpStart = function () return lb.Unlock(_G.PitchUpStart) end
	g.PitchDownStart = function () return lb.Unlock(_G.PitchDownStart) end
	g.PitchDownStop = function () return lb.Unlock(_G.PitchDownStop) end
	g.PitchUpStop = function () return lb.Unlock(_G.PitchUpStop) end
    g.ClearTarget = function () return lb.Unlock(_G.ClearTarget) end
	g.SetRaidTarget = function (...) lb.UnitTagHandler(_G.SetRaidTarget, ...) end
	g.GetRaidTargetIndex = function (...) lb.UnitTagHandler(_G.GetRaidTargetIndex, ...) end
	g.UnitIsWildBattlePet = function (...) return lb.UnitTagHandler(_G.UnitIsWildBattlePet, ...) end
	g.AcceptProposal = function (...) return lb.Unlock(_G.AcceptProposal, ...) end
	g.ObjectInteract = function (...) return lb.Unlock(_G.ObjectInteract, ...) end
	g.ClickPosition = function (...) return lb.Unlock(_G.ClickPosition, ...) end
	g.WorldToScreen = function (wX, wY, wZ)
		local ResolutionCoef = _G.WorldFrame:GetWidth() / lb.GetWindowSize()
		local sX, sY = lb.WorldToScreen(wX, wY, wZ)
		if sX and sY then
			return sX * ResolutionCoef, -sY * ResolutionCoef
		else
			return sX, sY
		end
    end
    f.ObjectExists = g.UnitExists
    f.UnitName = g.UnitName
    f.ObjectGUID = g.UnitGUID
end

function f.Cast(spell, target)
	g.CastSpellByName(spell, target)
end

function f.CastGround(spell, target)
	if not NeP.Protected.validGround[target] then
		target = "cursor"
	end
	NeP.Protected.Macro("/cast [@"..target.."]"..spell)
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
	if not NeP.DSL:Get('exists')(a)
	or not NeP.DSL:Get('exists')(b) then
        return 999
    end
    return lb.GetDistance3D(a, b) or 0
end

function f.UnitCombatRange(a, b)
    if not NeP.DSL:Get('exists')(a) or not NeP.DSL:Get('exists')(b) then
        return 999
    end
    local reachA = lb.UnitCombatReach(a) or 1.5
    local reachB = lb.UnitCombatReach(b) or 1.5
    local distance = NeP.DSL:Get('distance')(a, nil, b) or 0
    return distance - (reachA + reachB)
end

function f.LineOfSight(a, b)
    if not NeP.DSL:Get('exists')(a) or not NeP.DSL:Get('exists')(b) then
        return false
    end
    -- skip if its a boss
    if NeP.BossID:Eval(a) or NeP.BossID:Eval(b) then return true end
    local ax, ay, az = lb.ObjectPosition(a)
    if not ax then return false end
    local bx, by, bz = lb.ObjectPosition(b)
    return bx and not lb.Raycast(ax, ay, az + 2.25, bx, by, bz + 2.25, 0x100010)
end

function f.OM_Maker()
    for _, Obj in ipairs(lb.GetObjects(100)) do
        local xType = lb.ObjectType(Obj)
        NeP.OM:Add(Obj, xType == 8, xType == 11)
    end
end

function f.HttpsRequest(method, domain, url, body, xheaders, callback)
	local headers = {}
	for _,v in pairs(string.gmatch(xheaders, "\r\n")) do
		local hK, kV = string.gmatch(v, ': ')
		headers[#headers+1] = hK
		headers[#headers+1] = kV
	end
    g.HttpAsyncGet(
		domain,
		443,
		true,
		url,
		body,
		function(content)
			callback(content, 200)
		end,
		function(xerror)
			print('Error while loading...')
		end,
        unpack(headers)
	)
end

function f.downloadMedia(domain, url, path)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    local callback = function(body, status)
        if tonumber(status) ~= 200 then
			print('Failed to download media', status, path)
			return
        end
        g.WriteFile(path, body, false)
    end
    f.HttpsRequest('GET', domain, url, nil, nil, callback)
end

function f.mediaExists(path)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    return g.ReadFile(path) ~= nil
end

function f.readFile(path)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    return g.ReadFile(path)
end

function f.writeFile(path, body)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    return g.WriteFile(path, body, false)
end

NeP.Protected:AddUnlocker('LuaBox', {
	test = function() return g.__LB__ end,
	init = f.Load,
	prio = 1,
	functions = f,
})
