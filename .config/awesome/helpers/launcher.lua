local launcher = {}

function launcher.ror(cmd, classes)
  local matcher = function(c)
    return awful.rules.match_any(c, { class = classes })
  end
  -- i guess the raise_or_spawn should do the same as
  -- run_or_raise but i can't get it to work as is?
  -- return awful.spawn.raise_or_spawn(cmd, {}, matcher)
  return awful.client.run_or_raise(cmd, matcher, merge)
end

function launcher.run_once(cmd)
  awful.spawn.with_shell("ps -ef | grep -v grep | grep '" .. cmd .. "' > /dev/null || (" .. cmd .. ")")
end

return launcher
