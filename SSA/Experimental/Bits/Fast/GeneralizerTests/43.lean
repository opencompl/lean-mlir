import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize 6#32 <<< (x + 5#32) = 192#32 <<< x -- gshiftadd_proof#shl_add_nuw_thm; #42
