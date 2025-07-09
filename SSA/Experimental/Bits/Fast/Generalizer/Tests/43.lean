import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize 63#32 - (x &&& 31#32) = x &&& 31#32 ^^^ 63#32 -- gsubhxor_proof#low_mask_nsw_nuw_thm; #43
