# search for the keyword under the scope on various documentation website or google
#
# how to use: bind the "help_for_word" command to a keyboard shortcut
# put your cursor on the langage keyword, function, ... you want info on
# trigger the command via the shortcut > the documentation website or google is opened on your browser
#
# code is mostly http://dom111.co.uk/files/sublime/plugins/help_for_word.py
# just modified to take devdocs.io into account
import sublime
import sublime_plugin
import re


def open_url(url):
    sublime.active_window().run_command('open_url', {"url": url})


class HelpForWordCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        # define lookups here
        urls = {
            # r'scope\.name\.regex': 'http://url.for/%(function_name)s'
            r'support\.function\..+\.php': 'http://php.net/%s',
            r'(storage\..+|keyword\..+|support\..+|constant\.language)\.python': 'http://effbot.org/pyref/%s.htm'
        }

        for region in self.view.sel():
            scopes = self.view.scope_name(region.begin()).strip().split(' ')

            if region.empty():
                p = region.begin()

                # html specifics
                if self.view.scope_name(p).find('text.html.basic') > -1 and self.view.scope_name(p).find('embedded.block.html') == -1:
                    while p >= 0:
                        if self.view.substr(p) == '<' and self.view.scope_name(p).find('string.quoted.double.html') < 0:
                            p += 1

                            # check if it's an end tag
                            if self.view.substr(p) == '/':
                                p += 1

                            break

                        else:
                            p -= 1

                s = self.view.substr(self.view.word(p))

            else:
                s = self.view.substr(region)

            for scope in scopes:
                for search in urls.keys():
                    if re.search(search, scope):
                        open_url(urls[search] % s)
                        return

            else:
                # purloined from: http://www.sublimetext.com/forum/viewtopic.php?f=5&t=2242
                language = self.view.scope_name(self.view.sel()[0].begin()).strip().split('.')[-1]

                # devdocs: if langage is "js" we don't prepend the request with the langage because of underscore, jquery and all
                request = language + ' ' + s if language != "js" else s
                url = 'http://devdocs.io/#q=%s' if language in ["js", "css", "html"] else 'http://www.google.com/search?q=%s'
                open_url(url % request)
