local _, gbl = ...
local NeP = _G.NeP
gbl.Minibot = gbl.MergeTable(gbl.EWT, {})
local f = gbl.Minibot
local g = gbl.gapis

local ObjectTypes

local wrappers = {
	ObjectIsUnit = function(obj) return obj and g.ObjectIsType(obj, ObjectTypes.Unit) end,
	ObjectIsPlayer = function(obj) return obj and g.ObjectIsType(obj, ObjectTypes.Player) end,
	ObjectIsGameObject = function(obj) return obj and g.ObjectIsType(obj, ObjectTypes.GameObject) end,
	ObjectIsAreaTrigger = function(obj) return obj and g.ObjectIsType(obj, ObjectTypes.AreaTrigger) end,
}

function f.Load()
	local GetObjectTypeFlagsTable = _G.wmbapi.GetObjectTypeFlagsTable()
	ObjectTypes = {
		Object = GetObjectTypeFlagsTable.Object,
		Item = GetObjectTypeFlagsTable.Item,
		Container = GetObjectTypeFlagsTable.Container,
		AzeriteEmpoweredItem = GetObjectTypeFlagsTable.AzeriteEmpoweredItem,
		AzeriteItem = GetObjectTypeFlagsTable.AzeriteItem,
		Unit = GetObjectTypeFlagsTable.Unit,
		Player = GetObjectTypeFlagsTable.Player,
		ActivePlayer = GetObjectTypeFlagsTable.ActivePlayer,
		GameObject = GetObjectTypeFlagsTable.GameObject,
		DynamicObject = GetObjectTypeFlagsTable.DynamicObject,
		Corpse = GetObjectTypeFlagsTable.Corpse,
		AreaTrigger = GetObjectTypeFlagsTable.AreaTrigger,
		SceneObject = GetObjectTypeFlagsTable.SceneObject,
		ConversationData = GetObjectTypeFlagsTable.Conversation
	}
	local gapis = gbl.MergeTable(_G.wmbapi, gbl.gapis)
	gapis = gbl.MergeTable(wrappers, gapis)
	gbl.gapis = gapis 
end

function f.OM_Maker()
	for i=1, g.GetObjectCount() do
		local Obj = g.GetObjectWithIndex(i)
		NeP.OM:Add(Obj, g.ObjectIsType(Obj, ObjectTypes.GameObject))
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
