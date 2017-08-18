local _, gbl = ...
local NeP = NeP
local CastSpellByName = CastSpellByName
local RunMacroText = RunMacroText
local UseItemByName = UseItemByName
local UseInventoryItem = UseInventoryItem
local TargetUnit = TargetUnit
local SpellStopCasting = SpellStopCasting

-- Generic
gbl.Generic = {}

gbl.validGround = {
	["player"] = true,
	["cursor"] = true
}

function gbl.Generic.Cast(spell, target)
	CastSpellByName(spell, target)
end

function gbl.Generic.CastGround(spell, target)
	if not gbl.validGround[target] then
		target = "cursor"
	end
	gbl.Generic.Macro("/cast [@"..target.."]"..spell)
end

function gbl.Generic.Macro(text)
	RunMacroText(text)
end

function gbl.Generic.UseItem(name, target)
	UseItemByName(name, target)
end

function gbl.Generic.UseInvItem(name)
	UseInventoryItem(name)
end

function gbl.Generic.TargetUnit(target)
	TargetUnit(target)
end

function gbl.Generic.SpellStopCasting()
	SpellStopCasting()
end

gbl:AddUnlocker('Generic', {
	test = function()
		pcall(RunMacroText, '/run NeP.Unlocked = true')
		return NeP.Unlocked ~= nil
	end,
	functions = gbl.Generic,
})
