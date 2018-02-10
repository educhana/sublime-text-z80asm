#!/usr/bin/env bash
# ----------------------------------------------------------------------------
# This script builds the source. At first it's search for local make.sh 
# script. If not found, then search for makefile in the project folder. 
# If it's found - call it, otherwise run ASM against asm-file.
# Current directory at entry to this script is asm-file's directory.
# There are two input parameters:
#   1. filename (without path),
#   2. project file path. (ALWAYS EMPTY)
# ----------------------------------------------------------------------------

# Check if local make.sh file exists and it's executable
BUILD="./make.sh"
if [ -x $BUILD ]; then
	echo found $BUILD
	exec $BUILD "$1"
fi


# Check if there exists makefile
if [ -e "Makefile" ] || [ -e "makefile" ]; then
	echo make default target
	exec make
fi


# Default compilation ---------------------------------

# Remove filename extension
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
BASENAME="${1%.*}"

# Try to compile with our favourite assembler
ASM="sjasmplus"

# Simple compile
# exec $ASM "$1" 

# Compile with listings, symbols, exports
exec $ASM --lst="$BASENAME.lst" --sym="$BASENAME.sym" --exp="$BASENAME.exp" "$1"

