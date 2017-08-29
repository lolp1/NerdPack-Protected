local _, gbl                    = ...
local NeP                       = _G.NeP

gbl.FireHack = {}

function gbl.FireHack.Load()
	gbl.Generic.Load()
	gbl.ObjectPosition = _G.ObjectPosition
	gbl.CastAtPosition = _G.ClickPosition
	gbl.TraceLine = _G.TraceLine
	gbl.UnitCombatReach = _G.UnitCombatReach
	gbl.ObjectWithIndex = _G.GetObjectWithIndex
	gbl.ObjectCount = _G.GetObjectCount
	gbl.GetDistanceBetweenObjects = _G.GetDistanceBetweenObjects
	gbl.ObjectIsFacing = _G.ObjectIsFacing
	gbl.losFlags = _G.bit.bor(0x10, 0x100)
	gbl.ObjectExists = _G.ObjectExists
	gbl.IsHackEnabled = _G.IsHackEnabled
	gbl.SetHackEnabled = _G.SetHackEnabled
	gbl.CancelPendingSpell = _G.CancelPendingSpell
end

function gbl.FireHack.Distance(a, b)
	if not gbl.ObjectExists(a) or not gbl.ObjectExists(b) then return 999 end
	return gbl.GetDistanceBetweenObjects(a,b)
end

function gbl.FireHack.Infront(a, b)
	if not gbl.ObjectExists(a) or not gbl.ObjectExists(b) then return false end
	return gbl.ObjectIsFacing(a,b)
end

function gbl.FireHack.CastGround(spell, target)
	-- fallback to generic if we can cast it using macros
	if gbl.validGround[target] then
		return gbl.Generic.CastGround(spell, target)
	end
	if not gbl.ObjectExists(target) then return end
	local rX, rY = math.random(), math.random()
	local oX, oY, oZ = gbl.ObjectPosition(target)
	if oX then oX = oX + rX; oY = oY + rY end
	gbl.Generic.Cast(spell)
	if oX then gbl.CastAtPosition(oX, oY, oZ) end
	gbl.CancelPendingSpell()
end

function gbl.FireHack.UnitCombatRange(a, b)
	if not gbl.ObjectExists(a) or not gbl.ObjectExists(b) then return 999 end
	return gbl.FireHack.Distance(a, b) - (gbl.UnitCombatReach(a) + gbl.UnitCombatReach(b))
end

function gbl.FireHack.LineOfSight(a, b)
	if not gbl.ObjectExists(a) or not gbl.ObjectExists(b) then return false end
	-- skip if its a boss
	if NeP.BossID:Eval(a) or NeP.BossID:Eval(b) then return true end
	local ax, ay, az = gbl.ObjectPosition(a)
	local bx, by, bz = gbl.ObjectPosition(b)
	return not gbl.TraceLine(ax, ay, az+2.25, bx, by, bz+2.25, gbl.losFlags)
end

function gbl.FireHack_OM()
	for i=1, gbl.ObjectCount() do
		NeP.OM:Add(gbl.ObjectWithIndex(i))
	end
end

gbl:AddUnlocker('FireHack', {
	test = function() return _G.FireHack end,
	init = gbl.FireHack.Load,
	prio = 1,
	functions = gbl.Generic,
	extended = gbl.FireHack,
	om = gbl.FireHack_OM
})
