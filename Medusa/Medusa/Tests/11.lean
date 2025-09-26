import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (42#32 - x) <<< 3#32 = 336#32 - x <<< 3#32 -- PASSED gshlhsub_proof/shl_const_op1_sub_const_op0_thm; #11
