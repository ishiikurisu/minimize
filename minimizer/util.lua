local util = { }

-- Check if the two strings match their heads
util.match = function(s, t)
  local result = true
  local limit = math.min(#s, #t)

  for i = 1, limit do
    if s:sub(i, i) ~= t:sub(i, i) then
      result = false
    end
  end

  return result
end

return util
