#!/bin/bash

cache="$1"
target="$2"

if [[ -e "$target" ]]; then
    # If the target already has some files, we can be pretty sure those are 
    # up-to-date, so copy those into the cache mount
    rsync --archive --recursive "$target" "$cache"
fi
    
# Use bind-mounts, rather than symlinks, to avoid issues with the target
# already existing.
mount -o bind "$cache" "$target"