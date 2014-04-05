local helpers = {}

function helpers.contains(element, table)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

return helpers