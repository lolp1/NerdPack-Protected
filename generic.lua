local _, gbl = ...
local NeP = _G.NeP

-- Generic
gbl.Generic = {}

function gbl.Generic.Load()
	gbl.CastSpellByName = _G.CastSpellByName
	gbl.RunMacroText = _G.RunMacroText
	gbl.UseItemByName = _G.UseItemByName
	gbl.UseInventoryItem = _G.UseInventoryItem
	gbl.TargetUnit = _G.TargetUnit
	gbl.SpellStopCasting = _G.SpellStopCasting
end

gbl.validGround = {
	["player"] = true,
	["cursor"] = true
}

function gbl.Generic.Cast(spell, target)
	gbl.CastSpellByName(spell, target)
end

function gbl.Generic.CastGround(spell, target)
	if not gbl.validGround[target] then
		target = "cursor"
	end
	gbl.Generic.Macro("/cast [@"..target.."]"..spell)
end

function gbl.Generic.Macro(text)
	gbl.RunMacroText(text)
end

function gbl.Generic.UseItem(name, target)
	gbl.UseItemByName(name, target)
end

function gbl.Generic.UseInvItem(name)
	gbl.UseInventoryItem(name)
end

function gbl.Generic.TargetUnit(target)
	gbl.TargetUnit(target)
end

function gbl.Generic.SpellStopCasting()
	gbl.SpellStopCasting()
end

gbl:AddUnlocker('Generic', {
	test = function()
		pcall(gbl.RunMacroText, '/run NeP.Unlocked = true')
		return NeP.Unlocked ~= nil
	end,
	init = gbl.Generic.Load,
	functions = gbl.Generic,
})
