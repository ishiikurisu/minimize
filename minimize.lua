local minimizer = require 'minimizer/minimizer'

-- MAIN FUNCTIONS
if #arg > 0 then
  -- Checking if it should run this script on terminal mode
  if arg[0] == "minimize.lua" then
    minimizer.minimize(arg[1])
  end
end

return minimizer
