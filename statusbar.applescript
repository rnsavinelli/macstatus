use AppleScript version "2.4"
use scripting additions
use framework "Foundation"
use framework "AppKit"

property defaults : class "NSUserDefaults"

-- check that the application is running in foreground
-- IT MUST RUN AS APPLICATION to be thread safe and not crash.
if not (current application's NSThread's isMainThread()) as boolean then
	display alert "This script must be run from the main thread." buttons {"Cancel"} as critical
	error number -128
end if

-- create the NSStatusBar
on main()
	set bar to current application's NSStatusBar's systemStatusBar
	
	set statusItem to bar's statusItemWithLength:-1.0
	
	set forever to true
	repeat while forever
		set statusbar to do shell script "~/.local/bin/statusbar"
		-- set up the NSStatusBars title
		statusItem's setTitle:(statusbar)
		delay 5
	end repeat
end main

-- call the main function
my main()