local stringutils = {}

function stringutils.replace(str, search, replace)
  search = string.gsub(search, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
  replace = string.gsub(replace, "[%%]", "%%%%") -- escape replacement
  return string.gsub(str, search, replace)
end

function stringutils.sub8(s,i,j)
  i=utf8.offset(s,i)
  j=utf8.offset(s,j+1)-1
  return string.sub(s,i,j)
end

local function tchelper(first, rest)
   return first:upper()..rest:lower()
end

function stringutils.capitalize(str)
  -- Add extra characters to the pattern if you need to. _ and ' are
  --  found in the middle of identifiers and English words.
  -- We must also put %w_' into [%w_'] to make it handle normal stuff
  -- and extra stuff the same.
  -- This also turns hex numbers into, eg. 0Xa7d4
  return str:gsub("(%a)([%w_']*)", tchelper)
end

return stringutils
