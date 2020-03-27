import sublime, sublime_plugin

class ToggleHelpersCommand(sublime_plugin.ApplicationCommand):
    def run(self):
        self.settings = sublime.load_settings("Preferences.sublime-settings")

        toggle = not self.areVisibleHelpers()

        self.setSettings(toggle)

    def areVisibleHelpers(self):
        return self.settings.get("line_numbers")

    def setSettings(self, bool):
        self.settings.set("draw_indent_guides", bool)
        self.settings.set("line_numbers", bool)
        sublime.save_settings("Preferences.sublime-settings")
