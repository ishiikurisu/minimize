-- MAIN STRUCTURE
local minimizer = { }

minimizer.changeExtension = function(input, newExt)
  local index = #input

  while input:sub(index, index) ~= '.' do
      index = index - 1
  end

  local root = input:sub(1, index-1)
  return root .. newExt
end

minimizer.minimize = function(input)
  print("input: " .. input)
  local output = minimizer.changeExtension(input, '.min.lua')
  print("output: " .. output)
  local references = { }
  -- TODO Scan main file
  -- TODO Scan every file in reference until there are no more files
end

return minimizer
