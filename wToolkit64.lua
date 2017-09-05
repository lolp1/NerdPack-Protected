local _, gbl = ...

gbl.wToolkit64 = {}

function gbl.wToolkit64.Load()
end

function gbl.wToolkit64_OM()
	for i=1, _G.GetObjectCount() do
		local Obj = _G.GetObjectWithIndex(i)
		_G.NeP.OM:Add(Obj, false)
	end
end

gbl:AddUnlocker('wToolkit64', {
	test = function() return _G.wToolkit64 end,
	init = gbl.wToolkit64.Load,
	prio = 2,
	functions = gbl.Generic,
	extended = gbl.FireHack,
	om = gbl.wToolkit64_OM
})
