local _, gbl = ...

gbl:AddUnlocker('EasyWoWToolBox', {
	test = function() return EWT end,
	init = gbl.FireHack.Load,
	prio = 2,
	functions = gbl.Generic,
	extended = gbl.FireHack,
	om = gbl.FireHack_OM
})
