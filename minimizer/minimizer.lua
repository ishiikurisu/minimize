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

minimizer.identifyRequires = function(fileName, references)
  fp, error = io.open(fileName)

  line = fp:read()
  while line ~= nil do
    -- TODO Identify lines with requires
    local result = string.find(line, '= require')
    if result ~= nil then
      local required = line:sub(result+11, #line-1)
      table.insert(references, required)
    end
    line = fp:read()
  end

  return references
end

minimizer.minimize = function(input)
  print("input: " .. input)
  local output = minimizer.changeExtension(input, '.min.lua')
  print("output: " .. output)
  local references = { }
  -- TODO Scan main file
  print(input .. " requires:")
  references = minimizer.identifyRequires(input, references)
  for _, v in pairs(references) do
    print("- " .. v)
  end
  print("...")
  -- TODO Scan every file in reference until there are no more files
end

return minimizer
