import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x &&& 7#32 ||| y &&& 8#32) &&& 7#32 = x &&& 7#32 ---  gandhorand_proof/test1_thm; #39
