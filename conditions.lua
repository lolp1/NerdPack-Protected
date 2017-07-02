local NeP = NeP
local noop = function() return false end
local _advanced = IsHackEnabled ~= nil or false
local IsHackEnabled = IsHackEnabled or noop

NeP.DSL:Register("advanced", function()
	return _advanced
end)

NeP.DSL:Register("ishackenabled", function(_, hack)
	return IsHackEnabled(hack)
end)
