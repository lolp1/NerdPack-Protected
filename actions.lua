local NeP = NeP
local TargetUnit = TargetUnit

--USAGE in CR:
--{"%target", CONDITION, TARGET}
NeP.Actions:Add('target', function(eval)
  eval.exe = function(eva) TargetUnit(eva.target) end
  return true
end)
