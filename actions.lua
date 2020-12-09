local NeP = _G.NeP
local g = NeP._G

local bools = {
 ['TRUE'] = true,
 ['FALSE'] = false,
 ['NIL'] = nil
}

--USAGE in CR:
--{"%SetHack(HACK, ENABLE)", CONDITION}
NeP.Actions:Add('sethack', function(eval)
  local hack, bool = _G.strsplit(',', eval[1].args, 2)
  bool = bool and bool:upper() or 'NIL'
  eval.exe = function()
    if g.HackEnabled then
      g.HackEnabled(hack, bools[bool])
      return true
    end
  end
end)

--USAGE in CR:
--{"%SendKey(KEY)", CONDITION}
NeP.Actions:Add('sendkey', function(eval)
  eval.exe = function(eva)
    if g.SendKey then
      g.SendKey(eva[1].args)
      return true
    end
  end
end)
