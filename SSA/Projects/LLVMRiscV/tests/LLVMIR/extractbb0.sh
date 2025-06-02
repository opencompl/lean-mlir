#!/bin/bash


INPUT_FILE="$1"

awk '
  BEGIN { in_block = 0; }

  # Match the first line of the first basic block
  /^*\^bb0\(/ {
    in_block = 1;
  print "{"
   print $0
    next;
  }

  # While inside the block, keep printing lines
  in_block {
    print $0;

    # End when we see a return instruction
    if ($0 ~ /"llvm\.return"/) {
      in_block = 0;
      print "}"
      exit
    }
  }
' "$INPUT_FILE"
