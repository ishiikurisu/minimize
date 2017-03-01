local minimizer = require 'minimizer/minimizer'

-- MAIN FUNCTIONS
if #arg > 0 then
  -- Checking if it should run this script on terminal mode
  if string.find(arg[0], 'mini') then
    minimizer.minimize(arg[1])
  end
end

return minimizer
