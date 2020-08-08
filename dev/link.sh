#!/bin/bash
#
# Symlink built actions to the Keyboard Maestro Actions folder

ACTIONS_DIR="$HOME/Library/Application Support/Keyboard Maestro/Keyboard Maestro Actions"

if [ ! -d dist ] || [ -z "$(ls dist)" ]; then
	echo "'dist' folder is empty! Actions need to be built first."
	exit 1
fi

cd dist
dist=$(pwd)

for file in *
do
	name=$(basename "$file" .lbaction)
	echo "Symlinking \"$name\" to $ACTIONS_DIR/$file"
	cd "$ACTIONS_DIR"
	ln -s "$dist/$file" "$file"
done
