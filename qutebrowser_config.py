#print(c.bindings.commands)

c.tabs.position = "left"
c.tabs.show = "multiple"
c.auto_save.session = True
c.completion.use_best_match = True
c.content.cookies.store = False
c.content.geolocation = False
c.content.ssl_strict = True # Block all invalid HTTPS certificate requests (often google ads)

c.editor.command = [ "emacsclient", "-c", "-e", "(quickedit \"{file}\" {line} {column})" ]
c.downloads.location.directory = "~/Downloads/"
c.downloads.location.prompt = False
c.content.headers.user_agent = "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {qt_key}/{qt_version} {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}"

config.bind('n', 'run-with-count 2 scroll down')
config.bind('e', 'run-with-count 2 scroll up')
config.bind('y', 'scroll left')
config.bind('o', 'scroll right')

config.bind('O', 'set-cmd-text -s :open ')
config.bind('t', 'set-cmd-text -s :open -t ')

config.bind('s', 'tab-focus stack-prev')
config.bind('h', 'tab-focus stack-next')
config.bind('<Ctrl-s>', 'tab-prev')
config.bind('<Ctrl-h>', 'tab-next')
# <Alt-Num> for jumping to tab Num


config.bind('<Ctrl-k>', 'tab-clone')
config.bind('<Ctrl-O>', 'back')
config.bind('<Ctrl-F>', 'forward')
config.bind('<Ctrl-I>', 'forward')

config.bind('k', 'search-next')
config.bind('K', 'search-prev')

# config.bind('<Ctrl-i>', 'open-editor')
config.bind('<Ctrl-i>', 'open-editor', mode="insert")

config.bind('j', 'yank pretty-url')

config.bind('<Ctrl-0>', 'zoom 100')

config.bind('<Ctrl-Alt-H>', 'history')

config.bind(',m', "spawn mpv {url}")
config.bind(',M', "hint links spawn mpv {hint-url}")

config.bind(',z', "jseval var d=document,s=d.createElement('script');s.src='https://www.zotero.org/bookmarklet/loader.js';(d.body?d.body:d.documentElement).appendChild(s);void(0);")

# Remove binding to close all other tabs
config.unbind('co')

# Set the default font family
c.fonts.default_family = "Arial"
c.fonts.default_size = "12pt"

# tabbar
def makePadding(top, bottom, left, right):
    return { 'top': top, 'bottom': bottom, 'left': left , 'right': right }
c.tabs.padding = makePadding(3,1,8,8)
c.tabs.indicator.padding = makePadding(0,0,0,0)
config.load_autoconfig()
