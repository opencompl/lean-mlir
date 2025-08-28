import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x ||| y >>> 31#32) &&& 2#32 = x &&& 2#32 ---  gandhorand_proof/test4_thm; #40
