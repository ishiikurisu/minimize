local minimizer = { }

-- Creates a new extension for the given input file name
minimizer.changeExtension = function(input, newExt)
  local index = #input

  while input:sub(index, index) ~= '.' do
      index = index - 1
  end

  local root = input:sub(1, index-1)
  return root .. newExt
end

-- Discover which requires are done in the source code in file name
minimizer.identifyRequires = function(fileName, references)
  local fp, error = io.open(fileName)

  if error ~= nil then
    print("OOPS: " .. error)
    return references
  end

  local line = fp:read()
  while line ~= nil do
    -- TODO Identify lines with requires
    local result = string.find(line, '= require')
    if result ~= nil then
      local required = line:sub(result+11, #line-1)
      table.insert(references, required)
    end
    line = fp:read()
  end

  fp:close()
  return references
end

-- The main minimizer function
minimizer.minimize = function(input)
  print("input: " .. input)
  local output = minimizer.changeExtension(input, '.min.lua')
  print("output: " .. output)
  local references = { }

  -- # Scanning main file
  references = minimizer.identifyRequires(input, references)

  -- # Scanning every file in reference until there are no more files
  local flag = true
  local added = { }

  -- The flag will turn into true when there are new added files
  while flag do
    local tempRefs = references
    flag = false
    for _, reference in pairs(tempRefs) do
      if added[reference] ~= true then
        print(reference .. ".lua")
        added[reference] = true
        flag = true
        -- TODO Discover why this file can't be opened
        references = minimizer.identifyRequires(reference .. ".lua", references)
      end
    end
  end
  print("references:")
  for _, ref in pairs(references) do
    print("- " .. ref)
  end

  -- TODO Build main script
end

return minimizer
