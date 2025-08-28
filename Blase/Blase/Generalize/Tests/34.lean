import Blase.Generalize.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000

variable {x y : BitVec 8}
#generalize x &&& 3#8 &&& 4#8 = 0#8 --PASSED gand_proof/test8_thm; #34
