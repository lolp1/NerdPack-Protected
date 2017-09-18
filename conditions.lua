local NeP = _G.NeP

NeP.DSL:Register("advanced", function()
	return _G.HackEnabled ~= nil
end)

NeP.DSL:Register("ishackenabled", function(_, hack)
	return _G.HackEnabled and _G.HackEnabled(hack)
end)
