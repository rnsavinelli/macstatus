use AppleScript version "2.8"
use scripting additions
use framework "Foundation"
use framework "AppKit"

property statusItem : missing value
property timer : missing value

property configDir : POSIX path of (do shell script "echo ~/.config/statusbar/")
property scriptFilePath : configDir & "script"
property prefsFilePath : configDir & "preferences"

-- Ensure main thread
if not (current application's NSThread's isMainThread()) as boolean then
	display alert "This script must be run from the main thread." buttons {"Cancel"} as critical
	error number -128
end if

on main()
	ensureConfigFilesExist()
	
	set {editorName, updateInterval} to readPreferences()
	
	-- Create status bar item
	set bar to current application's NSStatusBar's systemStatusBar()
	set statusItem to bar's statusItemWithLength:(current application's NSVariableStatusItemLength)
	statusItem's setTitle:"Satusbar is loading..."
	statusItem's setHighlightMode:true
	
	-- Create menu
	set theMenu to (current application's NSMenu's alloc())'s initWithTitle:"Menu"
	
	-- Edit Script menu item
	set editScriptItem to current application's NSMenuItem's alloc()'s initWithTitle:"Edit Script" action:"editScript:" keyEquivalent:""
	editScriptItem's setTarget:me
	theMenu's addItem:editScriptItem
	
	-- Edit Settings menu item
	set editSettingsItem to current application's NSMenuItem's alloc()'s initWithTitle:"Settings" action:"editSettings:" keyEquivalent:""
	editSettingsItem's setTarget:me
	theMenu's addItem:editSettingsItem
	
	theMenu's addItem:(current application's NSMenuItem's separatorItem())
	
	-- Quit menu item
	set quitItem to current application's NSMenuItem's alloc()'s initWithTitle:"Quit" action:"quitApp:" keyEquivalent:"q"
	quitItem's setTarget:me
	theMenu's addItem:quitItem
	
	statusItem's setMenu:theMenu
	
	-- Start timer with interval from prefs
	if timer ­ missing value then timer's invalidate()
	set timer to current application's NSTimer's scheduledTimerWithTimeInterval:updateInterval target:me selector:"updateStatus:" userInfo:(missing value) repeats:true
	
	-- Update once immediately
	updateStatus_(missing value)
end main

-- Ensure config directory, script, and prefs exist with defaults
on ensureConfigFilesExist()
	do shell script "mkdir -p " & quoted form of configDir
	
	-- Create default script if missing
	try
		do shell script "[ -f " & quoted form of scriptFilePath & " ] || echo 'echo \"Welcome to statusbar!\"' > " & quoted form of scriptFilePath
		do shell script "chmod +x " & quoted form of scriptFilePath
	on error e
		display alert "Error creating script file: " & e
	end try
	
	-- Create default preferences if missing
	try
		do shell script "[ -f " & quoted form of prefsFilePath & " ] || echo $'editor=TextEdit
interval=5.0' > " & quoted form of prefsFilePath
	on error e
		display alert "Error creating preferences file: " & e
	end try
end ensureConfigFilesExist

-- Read preferences from file, return {editorName, updateInterval}
on readPreferences()
	try
		set prefsText to read POSIX file prefsFilePath as Çclass utf8È
	on error
		-- fallback defaults
		return {"TextEdit", 5.0}
	end try
	
	set editorName to "TextEdit"
	set updateInterval to 5.0
	
	set prefsLines to paragraphs of prefsText
	repeat with aLine in prefsLines
		if aLine starts with "editor=" then
			set startPos to (length of "editor=") + 1
			set editorName to text startPos thru -1 of aLine
		else if aLine starts with "interval=" then
			try
				set startPos to (length of "interval=") + 1
				set intervalString to text startPos thru -1 of aLine
				set updateInterval to intervalString as number
			end try
		end if
	end repeat
	
	
	if updateInterval < 1.0 then set updateInterval to 1.0
	
	return {editorName, updateInterval}
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

-- Edit the statusbar script file using the editor from prefs
on editScript:(sender)
	set {editorName, updateInterval} to readPreferences()
	do shell script "open -a " & quoted form of editorName & " " & quoted form of scriptFilePath
end editScript:

-- Edit the preferences file (settings)
on editSettings:(sender)
	set {editorName, updateInterval} to readPreferences()
	do shell script "open -a " & quoted form of editorName & " " & quoted form of prefsFilePath
end editSettings:

on reloadPreferences:sender
	set {editorName, updateInterval} to readPreferences()
	-- Restart timer with new interval
	if timer ­ missing value then timer's invalidate()
	set timer to current application's NSTimer's scheduledTimerWithTimeInterval:updateInterval target:me selector:"updateStatus:" userInfo:(missing value) repeats:true
end reloadPreferences:

-- Quit app
on quitApp:(sender)
	tell me to quit
end quitApp:

-- Start the app
main()

