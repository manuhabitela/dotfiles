local notifier = {}
local awful = require('awful')

function notifier.notify(args)
    if args and type(args) ~= 'table' then
        args = { title = args }
    end
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

return notifier