#!/bin/bash

# Check for skel
for target in .profile .bashrc .bash_logout
do
    [ -f $HOME/$target ] || cp /etc/skel/$target $HOME/
done

# Start the server
dumb-init /app/code-server/bin/code-server "$@"
