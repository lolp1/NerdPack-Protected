local _, gbl = ...
local NeP = _G.NeP
gbl.Minibot = gbl.MergeTable(gbl.Generic, {})
local f = gbl.Minibot
local g = gbl.gapis

--[[
	[ this is incomple, ported enough to get it working but some stubs might be missing ]
	https://github.com/pierre-picard/minibot-wow/blob/master/snippets/EWT-MiniBot-API.lua
]]

local ObjectTypes

function f.Load()
	local objectTypeFlagsTable = _G.wmbapi.GetObjectTypeFlagsTable()
	ObjectTypes = {
		Object = objectTypeFlagsTable.Object,
		Item = objectTypeFlagsTable.Item,
		Container = objectTypeFlagsTable.Container,
		AzeriteEmpoweredItem = objectTypeFlagsTable.AzeriteEmpoweredItem,
		AzeriteItem = objectTypeFlagsTable.AzeriteItem,
		Unit = objectTypeFlagsTable.Unit,
		Player = objectTypeFlagsTable.Player,
		ActivePlayer = objectTypeFlagsTable.ActivePlayer,
		GameObject = objectTypeFlagsTable.GameObject,
		DynamicObject = objectTypeFlagsTable.DynamicObject,
		Corpse = objectTypeFlagsTable.Corpse,
		AreaTrigger = objectTypeFlagsTable.AreaTrigger,
		SceneObject = objectTypeFlagsTable.SceneObject,
		ConversationData = objectTypeFlagsTable.Conversation
	}
	for k,v in pairs(_G.wmbapi) do g[k] = v end
	g.ObjectIsUnit = function(obj) return obj and g.ObjectIsType(obj, ObjectTypes.Unit) end
	g.ObjectIsPlayer = function(obj) return obj and g.ObjectIsType(obj, objectTypeFlagsTable.Player) end
	g.ObjectIsGameObject = function(obj) return obj and g.ObjectIsType(obj, ObjectTypes.GameObject) end
	g.ObjectIsAreaTrigger = function(obj) return obj and g.ObjectIsType(obj, ObjectTypes.AreaTrigger) end
	g.ObjectGUID = g.UnitGUID
	g.ObjectIsVisible = g.UnitIsVisible
	g.ObjectExists = g.ObjectExists
	g.ObjectTypes = ObjectTypes
	g.WorldToScreen = function(...)
		local scale, x, y = UIParent:GetEffectiveScale(), select(2,wmbapi.WorldToScreen(...))
		local sx = GetScreenWidth() * scale
		local sy = GetScreenHeight() * scale
		return x * sx, y * sy
	end
end

function f.ObjectCreator(a)
	return g.ObjectIsVisible(a) and g.ObjectCreator(a)
end

function f.GameObjectIsAnimating(a)
	return g.ObjectIsVisible(a) and g.GameObjectIsAnimating(a)
end

function f.Distance(a, b)
	if not NeP.DSL:Get('exists')(a)
	or not NeP.DSL:Get('exists')(b) then
        return 999
    end
    return g.GetDistanceBetweenObjects(a, b) or 0
end

function f.ObjectGUID(obj) return g.UnitGUID(obj) end

function f.UnitName(obj) return g.UnitName(obj) end

function f.Infront(a, b)
	if not NeP.DSL:Get('exists')(a)
	or not NeP.DSL:Get('exists')(b) then
        return false
    end
    return g.ObjectIsFacing(a, b)
end

function f.CastGround(spell, target)
    -- fallback to generic if we can cast it using macros
	if gbl.validGround[target] then
        return gbl.Generic.CastGround(spell, target)
    end
    if not NeP.DSL:Get('exists')(target) then return end
    -- Need to know if the spell comes from a Item for use UseItemByName or CastSpellByName
	local IsItem = g.GetItemSpell(spell)
	local func = IsItem and gbl.Generic.UseItem or gbl.Generic.Cast
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

function f.ObjectExists(Obj)
    return Obj and g.UnitExists(Obj) or g.ObjectExists(Obj)
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

function f.LineOfSight(a, b)
    if not NeP.DSL:Get('exists')(a) or not NeP.DSL:Get('exists')(b) then
        return false
    end
    -- skip if its a boss
    if NeP.BossID:Eval(a) or NeP.BossID:Eval(b) then return true end
    local ax, ay, az = g.ObjectPosition(a)
    if not ax then return false end
    local bx, by, bz = g.ObjectPosition(b)
    return bx and not g.TraceLine(ax, ay, az + 2.25, bx, by, bz + 2.25, g.bit.bor(0x10, 0x100))
end

function f.OM_Maker()
	for i=1, g.GetObjectCount() do
		local Obj = g.GetObjectWithIndex(i)
		NeP.OM:Add(Obj, g.ObjectIsGameObject(Obj), g.ObjectIsAreaTrigger(Obj))
	end
end

gbl:AddUnlocker('Minibot', {
	test = function()
		return _G.wmbapi ~= nil
	end,
    init = f.Load,
	prio = 4,
	functions = f,
})
