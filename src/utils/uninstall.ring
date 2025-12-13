# This file is part of the Ring HTML library.
# It provides functionality to remove the library files and clean up the environment.

load "stdlibcore.ring"

cPathSep = "/"

if isWindows()
	cPathSep = "\\"
ok

# Remove the html.ring file from the load directory
remove(exefolder() + "load" + cPathSep + "html.ring")

# Remove the html.ring file from the Ring2EXE libs directory
remove(exefolder() + ".." + cPathSep + "tools" + cPathSep + "ring2exe" + cPathSep + "libs" + cPathSep + "html.ring")

# Change current directory to the samples directory
chdir(exefolder() + ".." + cPathSep + "samples")

# Remove the UsingHTML directory if it exists
if direxists("UsingHTML")
	OSDeleteFolder("UsingHTML")
ok