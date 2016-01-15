#!/bin/bash

IGNORE='^install\.sh$|^.*~$'

for FILE in $(git ls-files); do
    if [[ "$FILE" =~ $IGNORE ]] ; then
	continue
    fi

    DOTFILE="$HOME/.$FILE"
    if [ ! -e $DOTFILE ] ; then
	echo "$DOTFILE doesn't exist - installing"
	install -b $FILE $DOTFILE
    elif [[ $FILE -nt $DOTFILE ]] ; then
	if ! cmp -s $FILE $DOTFILE; then
	    echo updating $DOTFILE
	    install -b $FILE $DOTFILE
	fi
    fi
done

