local _, gbl = ...

gbl.wToolkit64 = {}

function gbl.wToolkit64.Load()
end

gbl:AddUnlocker('wToolkit64', {
	test = function() return wToolkit64 end,
	init = gbl.wToolkit64.Load,
	prio = 2,
	functions = gbl.Generic,
	extended = gbl.FireHack,
	om = gbl.FireHack_OM
})
