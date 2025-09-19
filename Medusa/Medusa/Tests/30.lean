import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x ||| y <<< 1#32) &&& 1#32 = x &&& 1#32 --- PASSED gandhorand_proof/test3_thm; #30
