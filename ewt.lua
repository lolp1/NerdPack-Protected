
NeP.Protected.EWT = {}

local f = NeP.Protected.EWT
local g = NeP._G

function f.Load()
    g.GetDistanceBetweenObjects = function(Obj1, Obj2)
        local X1, Y1, Z1 = g.ObjectPosition(Obj1)
        if not (X1 and Y1 and Z1) then return 999 end
        local X2, Y2, Z2 = g.ObjectPosition(Obj2)
        if not (X2 and Y2 and Z2) then return 999 end
        return g.GetDistanceBetweenPositions(X1, Y1, Z1, X2, Y2, Z2)
    end
    NeP.Protected.nPlates = nil
end

NeP.Protected.validGround = {
	["player"] = true,
	["cursor"] = true
}

function f.Cast(spell, target)
	g.CastSpellByName(spell, target)
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

function f.Load()
	g.InCombatLockdown = function() return g.UnitAffectingCombat("player") end
	NeP.Protected.nPlates = nil
end

function f.ObjectCreator(a)
	if not g.ObjectExists(a) then
		return false
	end
	return g.ObjectCreator(a)
end

function f.GameObjectIsAnimating(a)
	if not g.ObjectExists(a) then
		return false
	end
    local animationState = g.ObjectAnimation(a)
	return animationState ~= nil and animationState > 0
end

function f.Distance(a, b)
	if not NeP.DSL:Get('exists')(a)
	or not NeP.DSL:Get('exists')(b) then
        return 999
    end
    return g.GetDistanceBetweenObjects(a, b) or 0
end

function f.ObjectGUID(obj)
    return _G.UnitGUID(obj) or g.ObjectGUID(obj)
end

function f.UnitName(obj)
    return _G.UnitName(obj) or g.ObjectName(obj)
end

function f.Infront(a, b)
	if not NeP.DSL:Get('exists')(a)
	or not NeP.DSL:Get('exists')(b) then
        return false
    end
    return g.ObjectIsFacing(a, b)
end

function f.CastGround(spell, target)
    -- fallback to generic if we can cast it using macros
    if NeP.Protected.validGround[target] then
        return f.Macro("/cast [@"..target.."]"..spell)
    end
    if not NeP.DSL:Get('exists')(target) then return end
    -- Need to know if the spell comes from a Item for use UseItemByName or CastSpellByName
	local IsItem = g.GetItemSpell(spell)
	local func = IsItem and f.UseItem or f.Cast
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

function f.OM_Maker()
	for i=1, g.ObjectCount() do
		local Obj = g.ObjectWithIndex(i)
		NeP.OM:Add(Obj, g.ObjectIsGameObject(Obj), g.ObjectIsAreaTrigger(Obj))
	end
end

function f.HttpsRequest(_, domain, url, body, headers, callback, flags)
    g.SendHTTPRequest(
        "https://" .. domain .. url,
        body,
        callback,
        headers..'\r\n',
        flags
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
    f.HttpsRequest('GET', domain, url, nil, "accept-encoding: gzip", callback, 0x2)
end

function f.mediaExists(path)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    return g.ReadFile(path) ~= nil
end

function f.readFile(path)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    return g.ReadFile(path)
end

function f.readFile(path, body)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    return g.WriteFile(path, body, false)
end

NeP.Protected:AddUnlocker('EasyWoWToolBox', {
    test = function() return _G.EWT end,
    init = f.Load,
    prio = 2,
    functions = f
})
