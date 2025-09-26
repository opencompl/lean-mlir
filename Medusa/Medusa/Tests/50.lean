import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize x <<< 3#32 &&& 15#32 ||| x <<< 5#32 &&& 60#32 = x <<< 3#32 &&& 8#32 ||| x <<< 5#32 &&& 32#32 -- gorhshiftedhmasks_proof#or_and_shifts1_thm; #50
