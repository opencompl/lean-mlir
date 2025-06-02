import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize 4#32 >>> (x + 1#32) = 2#32 >>> x -- gshiftadd_proof#lshr_exact_add_nuw_thm; #49
