local _, gbl = ...

gbl.EWT = {}

function gbl.EWT.Load()
	gbl.FireHack.Load()
	gbl.SendKey = _G.SendKey
end

gbl:AddUnlocker('EasyWoWToolBox', {
	test = function() return _G.EWT end,
	init = gbl.EWT.Load,
	prio = 2,
	functions = gbl.Generic,
	extended = gbl.FireHack,
	om = gbl.FireHack_OM
})
