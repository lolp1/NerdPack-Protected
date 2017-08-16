local _, gbl                    = ...
local NeP                       = NeP
local CancelPendingSpell        = CancelPendingSpell
local Gn = gbl.Generic

function gbl.load_firehack()
	gbl.ObjectPosition = ObjectPosition
	gbl.CastAtPosition = CastAtPosition
	gbl.TraceLine = TraceLine
	gbl.UnitCombatReach = UnitCombatReach
	gbl.ObjectWithIndex = ObjectWithIndex
	gbl.ObjectCount = ObjectCount
	gbl.GetDistanceBetweenObjects = GetDistanceBetweenObjects
	gbl.ObjectIsFacing = ObjectIsFacing
	gbl.losFlags = bit.bor(0x10, 0x100)
	gbl.ObjectExists = ObjectExists
end

gbl.FireHack = {}

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
		return Gn.CastGround(spell, target)
	end
	if not gbl.ObjectExists(target) then return end
	local rX, rY = math.random(), math.random()
	local oX, oY, oZ = gbl.ObjectPosition(target)
	if oX then oX = oX + rX; oY = oY + rY end
	Gn.Cast(spell)
	if oX then gbl.CastAtPosition(oX, oY, oZ) end
	CancelPendingSpell()
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
	test = function() return FireHack end,
	init = gbl.load_firehack,
	prio = 1,
	functions = gbl.Generic,
	extended = gbl.FireHack,
	om = gbl.FireHack_OM
})
