
NeP.Protected.Minibot = {}
local f = NeP.Protected.Minibot
local g = NeP._G

--[[
	https://github.com/pierre-picard/minibot-wow/blob/master/snippets/EWT-MiniBot-API.lua
]]

local ObjectTypes

function f.Load()
	local objectTypeFlagsTable = _G.wmbapi.GetObjectTypeFlagsTable()
	NeP.Protected.nPlates = nil
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
	g.ObjectCreator = g.UnitCreator
	g.ObjectExists = g.ObjectExists
	g.ObjectTypes = ObjectTypes
	g.WorldToScreen = function(...)
		local scale, x, y = UIParent:GetEffectiveScale(), select(2,wmbapi.WorldToScreen(...))
		local sx = GetScreenWidth() * scale
		local sy = GetScreenHeight() * scale
		return x * sx, y * sy
	end
end

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

function f.ResetAfk()
	g.ResetAfk()
end

function f.ObjectCreator(a)
	if not g.ObjectExists(a) then
		return nil
	end
	return g.ObjectField(a, 0x720, 15)
end

function f.GameObjectIsAnimating(a)
	if not g.ObjectExists(a) then
		return false
	end
	local animationState = g.ObjectField(a, 0x60, 3)
	return animationState ~= nil and animationState > 0
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
    return Obj and (g.UnitExists(Obj) or g.ObjectExists(Obj)) or false
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

function f.HttpsRequest(method, domain, url, body, headers, callback)
    g.SendHttpRequest({
		Url = "https://" .. domain .. url,
		Method = method,
		Headers = headers,
		Body = body,
		Callback = function(request, status)
			if (status ~= "SUCCESS") then
				return;
            end
            local _, response = g.ReceiveHttpResponse(request);
			callback(response.Body, status)
		end
	});
end

function f.downloadMedia(domain, url, path)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    local callback = function(body, status)
        if tonumber(status) ~= 200 then
            print('Failed to download media', path)
        end
        g.WriteFile(path, body, false)
    end
    f.HttpsRequest('GET', domain, url, nil, nil, callback)
end

function f.mediaExists(path)
    path = 'Interface\\AddOns\\'.. local_stream_name ..'\\' .. path
    return g.FileExists(path)
end

NeP.Protected:AddUnlocker('Minibot', {
	test = function()
		return _G.wmbapi ~= nil
	end,
    init = f.Load,
	prio = 4,
	functions = f,
})
