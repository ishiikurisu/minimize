local minimizer = require 'minimizer/minimizer'

-- MAIN FUNCTIONS
if #arg > 0 then
  -- Debugging args
  for k, v in pairs(arg) do
    print(k .. ": " .. v)
  end
  -- Checking if it should run this script on terminal mode
  if (arg[0] == "minimize.lua") or (arg[0] == "minimizer.min.lua") then
    minimizer.minimize(arg[1])
  end
end

return minimizer
