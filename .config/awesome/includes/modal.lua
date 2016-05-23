http://awesome.naquadah.org/doc/api/modules/keygrabber.html

The idea behind modal keybinding is to have the same key perform different functions depending on the 'mode' they were pressed in. In my setup, I have a client mode (activated by Mod4 + space), and 'no-mode' (the default behavior), so that 'x' maximizes a client in client mode, while it does nothing in 'no-mode'.
Awesome's Keygrabber API makes it super simple to implement modal key bindings. Basically you trigger the keygrabber on some key combination, which then listens for further key presses and triggers functions accordingly.
1. So you have a table that binds certain keys to their actions for that mode :
 -- mapping for modal client keys
   client_mode = {
     -- Set client on top
     o = function (c) c.ontop = not c.ontop end,
     -- Redraw the client
     d = function (c) c:redraw() end,
     -- Toggle floating status of the client
     u = awful.client.floating.toggle,
     -- toggle mark
     t = awful.client.togglemarked,
     -- make the client fullscreen
     f = function (c) c.fullscreen = not c.fullscreen  end,
     -- maximize the client
     x = function (c)
           c.maximized_horizontal = not c.maximized_horizontal
           c.maximized_vertical   = not c.maximized_vertical
     end
   }
2. And a keybinding that triggers the mode. The following binding goes in the clientkeys table:
 -- trigger client mode on Mod4 + space
 awful.key({ modkey }, "space", function(c)
     keygrabber.run(function(mod, key, event)
         if event == "release" then return true end
         keygrabber.stop()
         if client_mode[key] then client_mode[key](c) end
         return true
     end)
 end)
The line in bold is what checks if an action corresponding to the key grabbed exists in the client_mode table, and invokes it if present.