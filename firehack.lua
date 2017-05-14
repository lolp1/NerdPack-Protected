local _, glb                    = ...
local NeP                       = NeP
local GetDistanceBetweenObjects = GetDistanceBetweenObjects
local ObjectIsFacing            = ObjectIsFacing
local CancelPendingSpell        = CancelPendingSpell

-- Advanced APIs
local ObjectPosition  = ObjectPosition
local CastAtPosition  = CastAtPosition
local TraceLine       = TraceLine
local UnitCombatReach = UnitCombatReach
local ObjectWithIndex = ObjectWithIndex
local ObjectCount     = ObjectCount

glb.FireHack = {}

function glb.FireHack.Distance(a, b)
	return GetDistanceBetweenObjects(a,b)
end

function glb.FireHack.Infront(a, b)
	return ObjectIsFacing(a,b)
end

function glb.FireHack.CastGround(spell, target)
	-- this is to cast on cursor location
	if not target then
		glb.Generic.CastGround(spell)
		return
	end

	local rX, rY = math.random(), math.random()
	local oX, oY, oZ = ObjectPosition(target)
	if oX then oX = oX + rX; oY = oY + rY end
	glb.Generic.Cast(spell)
	if oX then CastAtPosition(oX, oY, oZ) end
	CancelPendingSpell()
end

function glb.FireHack.UnitCombatRange(unitA, unitB)
	return glb.FireHack.Distance(unitA, unitB) - (UnitCombatReach(unitA) + UnitCombatReach(unitB))
end

local losFlags = bit.bor(0x10, 0x100)
function glb.FireHack.LineOfSight(a, b)
	-- skip if its a boss
	if NeP.BossID:Eval(a) or NeP.BossID:Eval(b) then return true end

	local ax, ay, az = ObjectPosition(a)
	local bx, by, bz = ObjectPosition(b)
	return not TraceLine(ax, ay, az+2.25, bx, by, bz+2.25, losFlags)
end

function glb.FireHack_OM()
	for i=1, ObjectCount() do
		NeP.OM:Add(ObjectWithIndex(i))
	end
end

NeP:AddUnlocker('FireHack', function()
	return FireHack
end, glb.Generic, glb.FireHack, glb.FireHack_OM)