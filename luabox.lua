local _, gbl = ...
local NeP = _G.NeP
gbl.LuaBox = gbl.MergeTable(gbl.Generic, {})
local f = gbl.LuaBox
local g = gbl.gapis
local lb

function f.Load()
    NeP.Core:Print('LB is still under dev... v1')
    lb = g. _G.__LB__;
    local _G = _G
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
	g.CastingInfo = function (...) return lb.UnitTagHandler(_G.CastingInfo) end
	g.ChannelInfo = function (...) return lb.UnitTagHandler(_G.ChannelInfo) end
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
end

function f.OM_Maker()
    for i, GUID in ipairs(lb.GetObjects(100)) do
        print(Obj, lb.ObjectType(Obj) == 8)
        NeP.OM:Add(Obj, lb.ObjectType(Obj) == 8)
    end
end

gbl:AddUnlocker('LuaBox', {
	test = function() return _G.__LB__ end,
	init = f.Load,
	prio = 1,
	functions = f,
})
