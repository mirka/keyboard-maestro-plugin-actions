#!/bin/bash
#
# Build actions from src

# Reset dist folder
rm -rf dist
mkdir dist

# Copy files from src
cd src

for file in *
do
	cp -R "$file" "../dist"
done

# Process each action
cd ../dist
for action in *
do
	plist="$action/Keyboard Maestro Action.plist"
	name=$(defaults read "$(pwd)/$plist" Name)

	echo "📦 Building \"$name\""

	# Compile text scripts
	applescript="$action/default.applescript"
	if [ -e "$applescript" ]; then
		osacompile -l AppleScript -o "$action/default.scpt" "$applescript"
		rm "$applescript"
	fi
	javascript="$action/default.js"
	if [ -e "$javascript" ]; then
		osacompile -l JavaScript -o "$action/default.scpt" "$javascript"
		rm "$javascript"
	fi

	# Add common metadata to plist
	plutil -insert Author -string 'Lena Morita' "$plist"
	plutil -insert URL -string 'https://github.com/mirka/keyboard-maestro-plugin-actions' "$plist"

	# Rename
	mv "$action" "$name"
done

# Refresh Actions in Keyboard Maestro
osascript -e 'tell application "Keyboard Maestro" to reload'
osascript -e 'tell application "Keyboard Maestro Engine" to reload'
echo "✨ Refreshed Keyboard Maestro Actions"
