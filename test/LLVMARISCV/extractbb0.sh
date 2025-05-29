#!/bin/bash

#This is a shell script to extract the first basic block of a mlir file written in generic syntax.
#We assume that the first basic block in the file is to be extracted. This is reasonable since
# in our context we modell a main function and a helper function that is called by main and 
# implements the logic. Therefore we extract this block by extracting the first basic block.
INPUT_FILE="$1"

awk '
  BEGIN { in_block = 0; }

  # we are matching the first line of the first basic block, luckily mlir-transform always
  calls the block bb0. 

  /^*\^bb0\(/ {
    in_block = 1;
   print $0
    next;
  }

  # we collect all the instructions within the block.
  in_block {
    print $0;

    # we assume the block wellformed, hence we stop when we reach a return. This also stops us from
    collecting the main function.
    if ($0 ~ /"llvm\.return"/) {
      in_block = 0;
      exit
    }
  }
' "$INPUT_FILE"

