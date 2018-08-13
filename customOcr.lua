--[[
this is an exemple file to build OCRs
/run CustomOcr = true & scan for unlockers to be detected
]]

local _, gbl = ...
local _G = _G
local NeP = _G.NeP
gbl.CustomOcr = {}

local cast = NeP.Protected.Cast

gbl.CustomOcr.Cast = function(...)
	local _,_, eva = ...
	print(eva[1].id)
  cast(...)
end

_G.CustomOcr = false

gbl:AddUnlocker('CustomOcr', {
	test = function() return _G.CustomOcr end,
	functions = gbl.CustomOcr,
})
