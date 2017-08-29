local _, gbl = ...
local NeP = _G.NeP

NeP.DSL:Register("advanced", function()
	return gbl.IsHackEnabled ~= nil
end)

NeP.DSL:Register("ishackenabled", function(_, hack)
	return gbl.IsHackEnabled and gbl.IsHackEnabled(hack)
end)
