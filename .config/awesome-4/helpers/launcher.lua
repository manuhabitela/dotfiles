local launcher = {}

function launcher.ror(cmd, classes)
  if classes and type(classes) ~= "table" then
    classes = { classes }
  end
  local matcher = function(c)
    return awful.rules.match_any(c, { class = classes })
  end
  return awful.spawn.raise_or_spawn(cmd, {}, matcher)
end

function launcher.run_once(cmd)
  awful.spawn.with_shell("ps -ef | grep -v grep | grep '" .. cmd .. "' > /dev/null || (" .. cmd .. ")")
end

return launcher
