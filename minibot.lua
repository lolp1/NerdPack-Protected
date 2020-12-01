local _, gbl = ...
local NeP = _G.NeP
gbl.FireHack = gbl.MergeTable(gbl.Generic, {})
local f = gbl.FireHack
local g = gbl.gapis

gbl:AddUnlocker('Minibot', {
	test = function()
		return wmbapi ~= nil
	end,
    init = f.Load,
	prio = 1,
	functions = f,
})
