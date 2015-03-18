#!/bin/sh
set -e

echo "$1" > $FILE

# If a compile command is specified compile the program first.
if [ -n "$COMPILE" ]; then
    ${COMPILE}
fi

${EXEC}
