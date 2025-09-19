import Medusa.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000

variable {x y : BitVec 32}
#generalize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) -- PASSED gxor2_proof/test5_thm; #18
