local _, glb               = ...
local NeP                       = NeP
local CastSpellByName           = CastSpellByName
local GetCVar                   = GetCVar
local SetCVar                   = SetCVar
local CameraOrSelectOrMoveStart = CameraOrSelectOrMoveStart
local CameraOrSelectOrMoveStop  = CameraOrSelectOrMoveStop
local RunMacroText              = RunMacroText
local UseItemByName             = UseItemByName
local UseInventoryItem          = UseInventoryItem

-- Generic
glb.Generic = {}

local validGround = {
	["player"] = true,
	["cursor"] = true
}

function glb.Generic.Cast(spell, target)
	CastSpellByName(spell, target)
end

function glb.Generic.CastGround(spell, target)
	if validGround[target] then
		glb.Generic.Macro("/cast [@"..target.."]"..spell)
	else
		NeP.Core:Print("Tried to cast", spell, "on ground using and unsupported unlocker.")
		local stickyValue = GetCVar("deselectOnClick")
		SetCVar("deselectOnClick", "0")
		CameraOrSelectOrMoveStart(1)
		glb.Generic.Cast(spell)
		CameraOrSelectOrMoveStop(1)
		SetCVar("deselectOnClick", "1")
		SetCVar("deselectOnClick", stickyValue)
	end
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

NeP:AddUnlocker('Generic', function()
	pcall(RunMacroText, '/run NeP.Unlocked = true')
	return NeP.Unlocked
end, glb.Generic)
