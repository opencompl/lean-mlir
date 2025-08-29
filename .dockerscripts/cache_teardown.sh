#!/bin/bash

cache="$1"
target="$2"

umount "$target"
rsync --archive --recursive "$cache" "$target"