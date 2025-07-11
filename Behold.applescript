use AppleScript version "2.8"
use scripting additions
use framework "Foundation"
use framework "AppKit"

property statusItem : missing value
property timer : missing value

property configDir : POSIX path of (do shell script "echo ~/.config/behold/")
property scriptFilePath : configDir & "script"
property prefsFilePath : configDir & "preferences"

-- Ensure main thread
if not (current application's NSThread's isMainThread()) as boolean then
	display alert "This script must be run from the main thread." buttons {"Cancel"} as critical
	error number -128
end if

on main()
	ensureConfigFilesExist()
	
	set updateInterval to readPreferences()
	
	-- Create status bar item
	set bar to current application's NSStatusBar's systemStatusBar()
	set statusItem to bar's statusItemWithLength:(current application's NSVariableStatusItemLength)
	statusItem's setTitle:"Satusbar is loading..."
	statusItem's setHighlightMode:true
	
	-- Create menu
	set theMenu to (current application's NSMenu's alloc())'s initWithTitle:"Menu"
	
	-- Edit Script menu item
	set editScriptItem to current application's NSMenuItem's alloc()'s initWithTitle:"Edit Script" action:"editScript:" keyEquivalent:"e"
	editScriptItem's setTarget:me
	theMenu's addItem:editScriptItem
	
	-- Edit Settings menu item
	set editSettingsItem to current application's NSMenuItem's alloc()'s initWithTitle:"Edit Preferences" action:"editSettings:" keyEquivalent:"s"
	editSettingsItem's setTarget:me
	theMenu's addItem:editSettingsItem
	
	-- About menu item
	set aboutItem to current application's NSMenuItem's alloc()'s initWithTitle:"About" action:"showAbout:" keyEquivalent:"a"
	aboutItem's setTarget:me
	theMenu's addItem:aboutItem
	
	theMenu's addItem:(current application's NSMenuItem's separatorItem())
	
	-- Quit menu item
	set quitItem to current application's NSMenuItem's alloc()'s initWithTitle:"Quit" action:"quitApp:" keyEquivalent:"q"
	quitItem's setTarget:me
	theMenu's addItem:quitItem
	
	statusItem's setMenu:theMenu
	
	-- Start timer with interval from prefs
	if timer is not missing value then timer's invalidate()
	set timer to current application's NSTimer's scheduledTimerWithTimeInterval:updateInterval target:me selector:"updateStatus:" userInfo:(missing value) repeats:true
	
	-- Update once immediately
	updateStatus_(missing value)
end main

-- Show About dialog
on showAbout:(sender)
	set alert to current application's NSAlert's alloc()'s init()
	alert's setMessageText:"Behold"
	
	set infoText to "Version 1.0

Behold is a small and extensible macOS apple
developed by R. Nicolas Savinelli 
rnsavinelli@gmail.com

"
	set infoText to infoText & "The input script utilized by the applet and its preferences are stored in:
" & configDir & "
"
	
	alert's setInformativeText:infoText
	
	-- Add buttons for GitHub, Website, and OK
	alert's addButtonWithTitle:"Support the Developer"
	alert's addButtonWithTitle:"Close"
	
	set response to alert's runModal()
	
	if response = (current application's NSAlertFirstButtonReturn) then
		-- GitHub clicked
		do shell script "open https://github.com/rnsavinelli"
	end if
end showAbout:

-- Ensure config directory, script, and prefs exist with defaults
on ensureConfigFilesExist()
	do shell script "mkdir -p " & quoted form of configDir
	
	-- Create default script if missing
	try
		do shell script "[ -f " & quoted form of scriptFilePath & " ] || echo 'echo \"Welcome to Behold!\"' > " & quoted form of scriptFilePath
		do shell script "chmod +x " & quoted form of scriptFilePath
	on error e
		display alert "Error creating script file: " & e
	end try
	
	-- Create default preferences if missing
	try
		do shell script "[ -f " & quoted form of prefsFilePath & " ] || echo $'interval=5' > " & quoted form of prefsFilePath
	on error e
		display alert "Error creating preferences file: " & e
	end try
end ensureConfigFilesExist

-- Read preferences from file, return {updateInterval}
on readPreferences()
	try
		set prefsAlias to POSIX file prefsFilePath as alias
		set prefsText to read prefsAlias
	on error errMsg
		return 5.0
	end try
	
	set updateInterval to 5.0
	
	set prefsLines to paragraphs of prefsText
	repeat with aLine in prefsLines
		if aLine starts with "interval=" then
			try
				set startPos to (length of "interval=") + 1
				set intervalString to text startPos thru -1 of aLine
				set updateInterval to intervalString as number
			end try
		end if
	end repeat
	
	if updateInterval < 1.0 then set updateInterval to 1.0
	
	return updateInterval
end readPreferences

-- Update status bar text
on updateStatus:sender
	try
		set output to do shell script scriptFilePath
		statusItem's setTitle:(output)
	on error
		statusItem's setTitle:"Failed to start up the status bar!"
	end try
end updateStatus:

-- Edit the statusbar script file using the default macOS text editor
on editScript:(sender)
	do shell script "open -a 'TextEdit' " & quoted form of scriptFilePath
end editScript:

-- Edit the preferences file (settings)
on editSettings:(sender)
	do shell script "open -a 'TextEdit' " & quoted form of prefsFilePath
end editSettings:

-- Quit app
on quitApp:(sender)
	tell me to quit
end quitApp:

-- Start the app
main()