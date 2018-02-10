#!/usr/bin/env bash
# ----------------------------------------------------------------------------
# This script runs the emulator. At first it's search for emul.sh in the
# project folder. If it's found - call it, otherwise it will search for
# .sna/.spg/.trd/.scl/.tap and call EMUL with it.
# If no emul.sh file is found, it'll try to call make with 'run' target.
# Current directory at entry to this script is asm-file's directory.
# There are two input parameters:
#   1. filename (without path),
#   2. project file path. (empty)
# ----------------------------------------------------------------------------


# check if local run file exists and is executable
EMUL="./emul.sh"
if [ -x $EMUL ]; then
	echo found $EMUL

	# remove filename extension
	# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
	BASENAME="${1%.*}"
	# check if any of this extensions exists and call emul.sh with it.
	for ext in "sna" "spg" "trd" "scl" "tap"; do
		IMAGE="$BASENAME.$ext"
		if [ -e $IMAGE ]; then
			echo exec $EMUL $IMAGE
			exec $EMUL $IMAGE
		fi
	done

	# no image found. exec without parameters
	echo exec $EMUL
	exec $EMUL
fi



# last but not least, check makefile run target
if [ -e "Makefile" ] || [ -e "makefile" ]; then
	exec make run
fi
