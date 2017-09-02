local _, gbl = ...
local _G = _G
local NeP = _G.NeP

-- Generic
gbl.Generic = {}

function gbl.Generic.Load()
end

gbl.validGround = {
	["player"] = true,
	["cursor"] = true
}

function gbl.Generic.Cast(spell, target)
	_G.CastSpellByName(spell, target)
end

function gbl.Generic.CastGround(spell, target)
	if not gbl.validGround[target] then
		target = "cursor"
	end
	gbl.Generic.Macro("/cast [@"..target.."]"..spell)
end

function gbl.Generic.Macro(text)
	_G.RunMacroText(text)
end

function gbl.Generic.UseItem(name, target)
	_G.UseItemByName(name, target)
end

function gbl.Generic.UseInvItem(name)
	_G.UseInventoryItem(name)
end

function gbl.Generic.TargetUnit(target)
	_G.TargetUnit(target)
end

function gbl.Generic.SpellStopCasting()
	_G.SpellStopCasting()
end

gbl:AddUnlocker('Generic', {
	test = function()
		pcall(_G.RunMacroText, '/run NeP.Unlocked = true')
		return NeP.Unlocked ~= nil
	end,
	init = gbl.Generic.Load,
	functions = gbl.Generic,
})
