import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize x <<< 6#32 <<< 28#32 = 0#32   -- PASSED ; shl_shl_thm #10
