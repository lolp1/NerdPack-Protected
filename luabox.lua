local _, gbl = ...
local NeP = _G.NeP
gbl.LuaBox = gbl.MergeTable(gbl.Generic, {})
local f = gbl.LuaBox
local g = gbl.gapis

function f.Load()

end

function f.Cast(spell, target)
	g. __LB__.Unlock(g.CastSpellByName, spell, target)
end

function f.CastGround(spell, target)
	if not gbl.validGround[target] then
		target = "cursor"
	end
	NeP.Protected.Macro("/cast [@"..target.."]"..spell)
end

function f.Macro(text)
	g. __LB__.Unlock(g.RunMacroText, text)
end

function f.UseItem(name, target)
	g. __LB__.Unlock(g.UseItemByName, name, target)
end

function f.UseInvItem(name)
	g. __LB__.Unlock(g.UseInventoryItem, name)
end

function f.TargetUnit(target)
	g. __LB__.Unlock(g.TargetUnit, target)
end

function f.SpellStopCasting()
	g. __LB__.Unlock(g.SpellStopCasting)
end

gbl:AddUnlocker('LuaBox', {
	test = function() return _G.__LB__ end,
	init = f.Load,
	prio = 1,
	functions = f,
})
