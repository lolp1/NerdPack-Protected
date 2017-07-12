local _, gbl = ...
local NeP = NeP
local C_Timer = C_Timer

local unlockers = {}

function gbl.AddUnlocker(_, name, test, functions, extended, om, prio)
	table.insert(unlockers, {
		name = name,
		test = test,
		functions = functions,
		extended = extended,
		om = om;
		prio = prio or 0
	})
	table.sort( unlockers, function(a,b) return a.prio > b.prio end )
end

function gbl.SetUnlocker(_, name, unlocker)
	NeP.Core:Print('|cffff0000Found:|r ' .. name, '\nRemember to /reload after attaching a unlocker!')
	for uname, func in pairs(unlocker.functions) do
		NeP.Protected[uname] = func
	end
	if unlocker.extended then
		for uname, func in pairs(unlocker.extended) do
			NeP.Protected[uname] = func
		end
	end
	if unlocker.om then
		NeP.Protected.OM_Maker = unlocker.om
		NeP.Protected.nPlates = nil --Remove the nameplaces OM portion
	end
	NeP.Unlocked = true
end

--delay the ticker to allow addons to inject theyr stuff
C_Timer.After(5, function ()

C_Timer.NewTicker(0.2, function(self)
		if not NeP.DSL:Get('toggle')(nil, 'mastertoggle') then return end
		for i=1, #unlockers do
			local unlocker = unlockers[i]
			if unlocker.test() then
                NeP.Unlocked = nil -- this is created by the generic unlocker (get rid of it)
				gbl:SetUnlocker(unlocker.name, unlocker)
				self:Cancel()
				break
			end
		end
end, nil)

end)