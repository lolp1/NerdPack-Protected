local t_name, gbl = ...
gbl.EWT = gbl.MergeTable(gbl.FireHack, {})
local NeP = _G.NeP
local f = gbl.EWT
local g = gbl.gapis

local initOM = true
local objMap = {}

local function om()
    local total, updated, added, removed = g.GetObjectCount(true, t_name .. '_EWT_OM')
    if initOM then
        initOM = false
        for i = 1, total do
            local Obj = g.GetObjectWithIndex(i)
            objMap[tostring(Obj)] = g.ObjectGUID(Obj)
            NeP.OM:Add(Obj, g.ObjectIsGameObject(Obj), g.ObjectIsAreaTrigger(Obj))
        end
    end
    if not updated then return end
    for _, Obj in pairs(added) do
        objMap[tostring(Obj)] = g.ObjectGUID(Obj)
        NeP.OM:Add(Obj, g.ObjectIsGameObject(Obj), g.ObjectIsAreaTrigger(Obj))
    end
    for _, Obj in pairs(removed) do
        NeP.OM:RemoveObjectByGuid(objMap[tostring(Obj)])
    end
end

function f.Load()
    g.GetDistanceBetweenObjects = function(Obj1, Obj2)
        local X1, Y1, Z1 = g.ObjectPosition(Obj1)
        if not (X1 and Y1 and Z1) then return 999 end
        local X2, Y2, Z2 = g.ObjectPosition(Obj2)
        if not (X2 and Y2 and Z2) then return 999 end
        return g.GetDistanceBetweenPositions(X1, Y1, Z1, X2, Y2, Z2)
    end
    NeP.Timer.Add('nep_ewt_om', om, 0)
end

function f.Distance(a, b)
	if not NeP.DSL:Get('exists')(a)
	or not NeP.DSL:Get('exists')(b) then
        return 999
    end
    return g.GetDistanceBetweenObjects(a, b) or 0
end

function f.ObjectGUID(obj) return _G.UnitGUID(obj) or g.ObjectGUID(obj) end

function f.UnitName(obj) return _G.UnitName(obj) or g.ObjectName(obj) end

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
	local IsItem = NeP._G.GetItemSpell(spell)
	local func = IsItem and gbl.Generic.UseItem or gbl.Generic.Cast
	local oX, oY, oZ = NeP._G.ObjectPosition(target)
	local rX, rY = math.random(), math.random()
	if oX then
		oX = oX + rX;
        oY = oY + rY
		local i = -100
		func(spell)
        local mouselookup = NeP._G.IsMouseButtonDown(2)
        if mouselookup then NeP._G.MouselookStop() end
        while NeP._G.SpellIsTargeting() and i <= 100 do
            g.ClickPosition(oX, oY, oZ)
            i = i + 1
            oZ = i
        end
        if mouselookup then NeP._G.MouselookStart() end
        if i >= 100 and NeP._G.SpellIsTargeting() then
            NeP._G.SpellStopTargeting()
        end
    end
end

function f.ObjectExists(Obj)
    return Obj and _G.UnitExists(Obj) or g.ObjectExists(Obj)
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

function f.OM_Maker() end

gbl:AddUnlocker('EasyWoWToolBox', {
    test = function() return _G.EWT end,
    init = f.Load,
    prio = 2,
    functions = f
})
