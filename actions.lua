local NeP = NeP
local noop = function() end
local TargetUnit = TargetUnit
local SetHackEnabled = SetHackEnabled or noop
local strsplit = strsplit

local bools = {
 ['TRUE'] = true,
 ['FALSE'] = false,
 ['NIL'] = nil
}

--USAGE in CR:
--{"%target", CONDITION, TARGET}
NeP.Actions:Add('target', function(eval)
  eval.exe = function(eva) TargetUnit(eva.target)  end
  return true
end)

--USAGE in CR:
--{"%SetHack(HACK, ENABLE)", CONDITION}
NeP.Actions:Add('sethack', function(eval)
  local hack, bool = strsplit(',', eval[1].args, 2)
  bool = bool and bool:upper() or 'NIL'
  eval.exe = function()
      SetHackEnabled(hack, bools[bool])
      return true
  end
  return true
end)
