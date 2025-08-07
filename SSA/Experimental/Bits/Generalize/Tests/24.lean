import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x <<< 2#8 + (y <<< 2#8 + 48#8) = (y + x) <<< 2#8 + 48#8 ---  PASSED gbinophandhshifts_proof/shl_add_add_thm; #24
