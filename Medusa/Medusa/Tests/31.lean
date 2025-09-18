import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x <<< 1#8 ^^^ y <<< 1#8 &&& 20#8 = (x ^^^ y &&& 10#8) <<< 1#8  --- PASSED gbinophandhshifts_proof/shl_and_xor_thm; #31
