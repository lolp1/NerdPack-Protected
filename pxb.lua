local _, gbl = ...
local _G = _G
local NeP = _G.NeP
gbl.PXB = {}

local pxbFrame = CreateFrame("Frame", "pxbFrame", NePFaceroolFrame)
-- local pxbFrame = CreateFrame("Frame", "pxbFrame", _G.UIParent)
pxbFrame:SetWidth(20)
pxbFrame:SetHeight(20)
pxbFrame:ClearAllPoints()
pxbFrame:SetPoint("TOPLEFT", UIParent, 0, 0);
pxbFrame:Show()

local function GetSpellColor (spellId)
  strspellId = format("%06d", spellId)
  local r = "." .. string.sub(strspellId, 1, 2)
  local g = "." .. string.sub(strspellId, 3, 4)
  local b = "." .. string.sub(strspellId, 5, 6)

  -- print("color", r, g, b)
  return r, g, b
end

local function ChangeColor (spellId)
  -- print("spellId", eva[1].id)
  if spellId ~= nil then
    r, g, b = GetSpellColor(spellId)

    if not pxbFrame.BG then
      pxbFrame.BG = pxbFrame:CreateTexture("BACKGROUND")
      pxbFrame.BG:SetAllPoints(pxbFrame)
      if not pxbFrame:IsVisible() then
        pxbFrame:Show()
      end
    end

    pxbFrame.BG:SetColorTexture(r, g, b)
  end
end


local cast = NeP.Protected.Cast

gbl.PXB.Cast = function(...)
  local _,_, eva = ...
  ChangeColor(eva[1].id)
  cast(...)
end

-- Turned off by default
_G.PXB = false

gbl:AddUnlocker("PXB", {
  test = function() return _G.PXB end,
  functions = gbl.PXB,
})


-- TODO : figure out how to hook onto Faceroll.Hide to black our frame out
-- local hide = NeP.Faceroll.Hide
--
-- NeP.Faceroll.Hide = function(...)
--   pxbFrame:Hide()
--   hide(...)
-- end
