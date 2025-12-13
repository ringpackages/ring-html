# This file is part of the Ring HTML library.

# Load the Ring HTML library based on the operating system.
if isWindows()
    loadlib("ring_html.dll")
but isLinux() or isFreeBSD()
    loadlib("libring_html.so")
but isMacOSX()
    loadlib("libring_html.dylib")
else
    raise("Unsupported OS! You need to build the library for your OS.")
ok

# Load the Ring HTML Class and Constants.
load "src/html.ring"