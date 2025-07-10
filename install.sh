#!/bin/bash

echo ":: Removing old builds of Statusbar.app"

rm -fr ./Statusbar.app 

echo ":: Compiling statusbar.applescript into Statusbar.app"

osacompile -o Statusbar.app statusbar.applescript

echo ":: Adding custom properties to Statusbar.app/Contents/Info.plist"

patch ./Statusbar.app/Contents/Info.plist < ./patches/Info.plist.patch  

echo ":: Removing old builds of Statusbar.app installed inside /Applications/Utilities/"

sudo rm -r /Applications/Utilities/Statusbar.app

echo ":: Placing Statusbar.app into /Applications/Utilities/"

sudo mv ./Statusbar.app /Applications/Utilities/

echo ":: Registering Statusbar.app as a Login Item"

osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Utilities/Statusbar.app", hidden:false}'

echo ":: Installation complete"