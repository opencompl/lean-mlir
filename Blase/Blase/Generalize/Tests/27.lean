import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x <<< 1#8 + (y <<< 1#8 &&& 119#8) = (x + (y &&& 59#8)) <<< 1#8 --- PASSED gbinophandhshifts_proof/shl_and_add_thm; #27
