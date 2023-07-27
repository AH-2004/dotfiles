#!/usr/bin/sh

while true
do
	inotifywait -e modify README.md
	git add README.md
	git commit -m $(date +"%B %d %Y - %r")
	git push
done
