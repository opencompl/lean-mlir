import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x <<< 1#8 &&& y <<< 1#8 + 123#8 = (x &&& y + 61#8) <<< 1#8 ---PASSED gbinophandhshifts_proof/shl_add_and_thm; #28
