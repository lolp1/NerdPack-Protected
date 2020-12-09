local NeP = _G.NeP
local g = NeP._G

NeP.DSL:Register("advanced", function()
	return g.HackEnabled ~= nil
end)

NeP.DSL:Register("ishackenabled", function(_, hack)
	return g.HackEnabled and g.HackEnabled(hack)
end)
