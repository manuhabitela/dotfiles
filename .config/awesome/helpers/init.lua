local helpers = {}
local awful = require('awful')

function helpers.contains(element, table)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function helpers.notify(args)
	if not args.title then return false end
	local title = args.title
	local text = args.text or nil
	local urgency = args.urgency or nil
	local time = args.time or nil

	local cmd = "notify-send"
	if urgency then cmd = cmd.." -u "..urgency end
	if time then cmd = cmd.." -t "..time end
	cmd = cmd.." \""..title.."\""
	if text then cmd = cmd.." "..text end
	awful.util.spawn_with_shell(cmd)
	return true
end

return helpers