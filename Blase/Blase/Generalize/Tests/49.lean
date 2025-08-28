import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x &&& 7#32) <<< 3#32 ||| x <<< 2#32 &&& 28#32 = x <<< 3#32 &&& 56#32 ||| x <<< 2#32 &&& 28#32 -- gorhshiftedhmasks#or_and_shift_shift_and_thm #49
