local awful = require("awful")

local launcher = {}

function launcher.ror(cmd, classes, merge)
  if classes and type(classes) ~= "table" then
    classes = { classes }
  end
  local matcher = function(c)
    return awful.rules.match_any(c, { class = classes })
  end
  return awful.client.run_or_raise(cmd, matcher, merge)
end

function launcher.run_once(cmd)
  awful.util.spawn_with_shell("ps -ef | grep -v grep | grep '" .. cmd .. "' > /dev/null || (" .. cmd .. ")")
end

return launcher
