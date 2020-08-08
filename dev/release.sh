#!/bin/bash
#
# Prepare zip files for release

rm -rf release
mkdir release

cd dist
for file in *
do
	echo "👉 $file"
	zip -r "../release/$file.zip" "$file"
done
