-- autostarting apps - awesome_boot loads every .desktop file in standard autostart folder
-- awful.spawn.with_shell("awesome_boot")
-- I just *can't* manage to start xmodmap at boot correctly, so, putting that here...
helpers.launcher.run_once("/home/manu/bin/dynamic-xmodmap")
helpers.launcher.run_once("/home/manu/bin/xtrempro-dirty-idle-fix")
helpers.launcher.run_once("redshift-gtk")
helpers.launcher.run_once("pasystray")
helpers.launcher.run_once("cbatticon")
helpers.launcher.run_once("greenclip daemon")
helpers.launcher.run_once(terminal)
