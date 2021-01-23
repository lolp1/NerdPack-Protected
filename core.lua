local noop = function() end
NeP.Protected.version = 2.0
NeP.Protected.unlocked = false
local unlockers = {}

NeP.Protected.validGround = {
	["player"] = true,
	["cursor"] = true
}

function NeP.Protected.AddUnlocker(_, name, eval)
	table.insert(unlockers, {
		name = name,
		test = eval.test,
		functions = eval.functions or {},
		extended = eval.extended or {},
		om = eval.om;
		init = eval.init or noop,
		prio = eval.prio or 0
	})
	table.sort( unlockers, function(a,b) return a.prio > b.prio end )
end

function NeP.Protected.SetUnlocker(_, name, unlocker)
	NeP.Core:Print('|cffff0000Found:|r ' .. name)
	NeP.Protected.unlocker = name or ''
	C_Timer.After(1, NeP.Interface.UpdateTitle)
	unlocker.init()
	NeP.Protected.MergeTable(unlocker.functions, NeP.Protected)
end

local _loads = NeP.Protected.callbacks
function NeP.Protected.TryLoads()
	for i=1, #_loads do
		if _loads[i] and _loads[i]() then
			_loads[i] = nil
		end
	end
end

function NeP.Protected.FindUnlocker()
	for i=1, #unlockers do
		local unlocker = unlockers[i]
		if unlocker.test() then
			NeP.Unlocked = nil -- this is created by the generic unlocker (get rid of it)
			NeP.Protected:SetUnlocker(unlocker.name, unlocker)
			NeP.Protected.TryLoads()
			return true
		end
	 end
end

function NeP.Protected.MergeTable(a,b)
    for name, func in pairs(a) do
        b[name] = func
    end
    return b
end

-- next frame
NeP.Core:WhenInGame(NeP.Protected.FindUnlocker, -9999)