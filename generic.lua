local n_name, glb               = ...
local NeP                       = NeP
local CastSpellByName           = CastSpellByName
local RunMacroText              = RunMacroText
local UseItemByName             = UseItemByName
local UseInventoryItem          = UseInventoryItem
local StaticPopup1							= StaticPopup1

NeP.Listener:Add(n_name, "ADDON_ACTION_FORBIDDEN", function(...)
	local addon = ...
	if addon == n_name then
		StaticPopup1:Hide()
		NeP.Core:Print('Didnt find any unlocker, using facerool.')
	end
end)

-- Generic
glb.Generic = {
	validGround = {
		["player"] = true,
		["cursor"] = true
	}
}

function glb.Generic.Cast(spell, target)
	CastSpellByName(spell, target)
end

function glb.Generic.CastGround(spell, target)
	if not glb.Generic.validGround[target] then
		target = "cursor"
	end
	glb.Generic.Macro("/cast [@"..target.."]"..spell)
end

function glb.Generic.Macro(text)
	RunMacroText(text)
end

function glb.Generic.UseItem(name, target)
	UseItemByName(name, target)
end

function glb.Generic.UseInvItem(name)
	UseInventoryItem(name)
end

glb:AddUnlocker('Generic', function()
	pcall(RunMacroText, '/run NeP.Unlocked = true')
	return NeP.Unlocked ~= nil
end, glb.Generic)
