-- error handling
-- check if awesome encountered an error during startup and fell back to
-- another confiwallpaperg (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  helpers.notifier.notify({
    urgency = "critical",
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end
-- handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true
    helpers.notifier.notify({
      urgency = "critical",
      title = "Oops, an error happened!",
      text = err
    })
    in_error = false
  end)
end

naughty.connect_signal("request::display_error", function(message, startup)
  helpers.notifier.notify({
    urgency = "critical",
    title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
    text    = message
  })
end)
