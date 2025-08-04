import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize ((x >>> 4#32 &&& 8#32) + y) <<< 4#32 = (x &&& 128#32) + y <<< 4#32 --#PASSED gshlhbo_proof/shl_add_and_lshr_thm; #12
