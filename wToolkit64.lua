local _, gbl = ...

gbl:AddUnlocker('wToolkit64', {
	test = function() return wToolkit64 end,
	init = gbl.load_firehack,
	prio = 2,
	functions = gbl.Generic,
	extended = gbl.FireHack,
	om = gbl.FireHack_OM
})
