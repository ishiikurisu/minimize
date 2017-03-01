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
  local fp, error = io.open(fileName)

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

  fp:close()
  return references
end

minimizer.minimize = function(input)
  print("input: " .. input)
  local output = minimizer.changeExtension(input, '.min.lua')
  print("output: " .. output)
  local references = { }

  -- # Scanning main file
  print(input .. " requires:")
  references = minimizer.identifyRequires(input, references)
  for _, v in pairs(references) do
    print("- " .. v)
  end
  print("...")

  -- TODO Scan every file in reference until there are no more files
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
end

return minimizer
