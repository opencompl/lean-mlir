import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x + (y >>> 5#32 &&& 127#32)) <<< 5#32 = (y &&& 4064#32) + x <<< 5#32 --- PASSED gshlhbo_proof/lshr_add_and_shl_thm; #14
