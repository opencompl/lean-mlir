import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x &&& 12#32 ^^^ 15#32) &&& 1#32 = 1#32 -- gand_proof/test10_thm; #41
