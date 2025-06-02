import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize (x <<< 2#8 + 4#8) >>> 2#8 = x + 1#8 &&& 63#8 -- glshr_proof#lshr_exact_thm; #47
